-- ============================================================================
-- LANGUAGE SERVER PROTOCOL (LSP) CONFIGURATION
-- ============================================================================
-- This file configures various language servers for enhanced development experience
-- It provides features like autocompletion, diagnostics, and code navigation

-- Import NvChad's default LSP configurations
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- ============================================================================
-- BASIC LANGUAGE SERVERS
-- ============================================================================
-- Simple servers that work with default configuration
-- Basic servers (excluding pyright to avoid conflicts)
local servers = { 
  "html",   -- HTML language server
  "cssls",  -- CSS language server
  "gopls"   -- Go language server (basic setup, detailed config below)
}
vim.lsp.enable(servers)

-- ============================================================================
-- PYTHON LANGUAGE SERVER (PYRIGHT)
-- ============================================================================
-- Pyright configuration optimized for Django development
-- Single Python LSP to avoid conflicts with other Python language servers
lspconfig.pyright.setup {
  -- ============================================================================
  -- ROOT DIRECTORY DETECTION
  -- ============================================================================
  -- Intelligently detect project root, prioritizing Django projects with venv
  root_dir = function(fname)
    -- Look for venv folder at the same level as project root
    local util = require('lspconfig.util')
    local root = util.root_pattern('manage.py', 'pyproject.toml', 'setup.py', '.git')(fname)
    if root then
      -- Check if venv exists at the same level
      local venv_path = root .. '/venv'
      if vim.fn.isdirectory(venv_path) == 1 then
        return root
      end
    end
    -- Fallback to default root detection
    return util.root_pattern('manage.py', 'pyproject.toml', 'setup.py', '.git')(fname)
  end,
  
  settings = {
    python = {
      -- ========================================================================
      -- ANALYSIS SETTINGS (OPTIMIZED FOR DJANGO)
      -- ========================================================================
      -- Disable most type checking to reduce noise in Django projects
      analysis = {
        extraPaths = {"."},                   -- Add current directory to Python path
        autoSearchPaths = true,               -- Auto-discover Python paths
        useLibraryCodeForTypes = true,        -- Use library code for type information
        typeCheckingMode = "off",             -- Turn off strict type checking to reduce Django warnings
        autoImportCompletions = true,         -- Enable auto-import suggestions
        stubPath = "./typings",               -- Path to custom type stubs
        diagnosticMode = "workspace",         -- Analyze entire workspace
        
        -- Django-specific settings to reduce common warnings
        reportMissingImports = "warning",     -- Show missing imports as warnings
        reportMissingTypeStubs = false,       -- Don't warn about missing type stubs
        reportGeneralTypeIssues = false,      -- Don't warn about general type issues
        reportOptionalMemberAccess = false,   -- Don't warn about optional member access
        reportOptionalSubscript = false,      -- Don't warn about optional subscripts
        reportPrivateImportUsage = false,     -- Don't warn about private import usage
        reportUnknownMemberType = false,      -- Don't warn about unknown member types
        reportUnknownArgumentType = false,    -- Don't warn about unknown argument types
        reportUnknownVariableType = false,    -- Don't warn about unknown variable types
        reportUnknownParameterType = false,   -- Don't warn about unknown parameter types
        reportMissingParameterType = false,   -- Don't warn about missing parameter types
        reportMissingTypeArgument = false,    -- Don't warn about missing type arguments
        reportUntypedFunctionDecorator = false, -- Don't warn about untyped function decorators
        reportUntypedClassDecorator = false,  -- Don't warn about untyped class decorators
        reportUntypedBaseClass = false,       -- Don't warn about untyped base classes
        reportUntypedNamedTuple = false,      -- Don't warn about untyped named tuples
        reportPrivateUsage = false,           -- Don't warn about private usage
        reportConstantRedefinition = false,   -- Don't warn about constant redefinition
        reportIncompatibleMethodOverride = false, -- Don't warn about method overrides
        reportIncompatibleVariableOverride = false, -- Don't warn about variable overrides
        reportOverlappingOverload = false,    -- Don't warn about overlapping overloads
      },
    }
  },
  
  -- ============================================================================
  -- DYNAMIC PYTHON PATH CONFIGURATION
  -- ============================================================================
  -- Automatically detect and set the correct Python interpreter path
  on_new_config = function(new_config, new_root_dir)
    -- Set python path dynamically when LSP starts
    local venv_python = new_root_dir .. '/venv/bin/python'
    if vim.fn.executable(venv_python) == 1 then
      -- Use virtual environment Python if available
      new_config.settings.python.pythonPath = venv_python
    else
      -- Fallback to system Python
      new_config.settings.python.pythonPath = vim.fn.exepath('python3') or vim.fn.exepath('python')
    end
  end,
}

-- ============================================================================
-- GO LANGUAGE SERVER (GOPLS)
-- ============================================================================
-- Advanced Go LSP configuration with optimized settings for Go development
lspconfig.gopls.setup {
  -- ============================================================================
  -- GOPLS SETTINGS CONFIGURATION
  -- ============================================================================
  settings = {
    gopls = {
      -- ========================================================================
      -- STATIC ANALYSIS CONFIGURATION
      -- ========================================================================
      -- Fine-tune which analyses are enabled to reduce noise
      analyses = {
        unusedparams = true,              -- Report unused function parameters
        simplifycompositelit = false,     -- Don't suggest composite literal simplification
        unusedwrite = false,              -- Don't report unused writes
        fillreturns = false,              -- Don't suggest filling return statements
        nonewvars = false,                -- Don't report variables that could be declared in shorter form
        fieldalignment = false,           -- Don't suggest struct field alignment optimizations
        nilness = false,                  -- Don't report nilness analysis
        useany = false,                   -- Don't suggest using 'any' instead of 'interface{}'
        ifaceany = false,                 -- Disable "interface{} can be replaced" warnings
        ST1003 = false,                   -- Disable staticcheck rule ST1003 (interface{} replacement)
      },
      
      -- ========================================================================
      -- LINTER AND FORMATTER INTEGRATION
      -- ========================================================================
      staticcheck = false,                -- Disable staticcheck integration to reduce warnings
      gofumpt = true,                     -- Enable gofumpt for stricter formatting
      
      -- ========================================================================
      -- COMPLETION SETTINGS
      -- ========================================================================
      completeUnimported = true,          -- Show completions for unimported packages
      usePlaceholders = true,             -- Use placeholders in function completions
      matcher = "Fuzzy",                  -- Use fuzzy matching for better completion experience
    },
  },
  
  -- ============================================================================
  -- CUSTOM DIAGNOSTIC HANDLERS
  -- ============================================================================
  -- Filter out specific diagnostic messages to reduce noise
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      if result.diagnostics then
        -- Filter out "interface{} can be replaced" warnings
        result.diagnostics = vim.tbl_filter(function(diagnostic)
          return not (diagnostic.message:find("interface{}") and diagnostic.message:find("can be replaced"))
        end, result.diagnostics)
      end
      -- Pass filtered diagnostics to default handler
      vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    end,
  },
}

-- ============================================================================
-- ADDITIONAL NOTES
-- ============================================================================
-- For more information on configuring LSP servers, read :h vim.lsp.config
-- Each language server can be customized with specific settings, capabilities,
-- and event handlers to match your development workflow
