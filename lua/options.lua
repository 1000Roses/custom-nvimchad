-- ============================================================================
-- NEOVIM OPTIONS AND EDITOR SETTINGS
-- ============================================================================
-- This file contains global editor options and language-specific configurations
-- It extends NvChad's default options with custom settings for development

-- Load NvChad's default options first
require "nvchad.options"

-- ============================================================================
-- GLOBAL EDITOR SETTINGS
-- ============================================================================
local o = vim.o      -- Global options
local opt = vim.opt  -- Option object for easier manipulation

-- Default indentation settings (applies to most file types)
opt.tabstop = 4        -- Number of spaces a tab character represents
opt.shiftwidth = 4     -- Number of spaces for each indentation level
opt.expandtab = true   -- Convert tabs to spaces
opt.autoindent = true  -- Copy indent from current line when starting new line
opt.smartindent = true -- Smart autoindenting for new lines

-- ============================================================================
-- DJANGO TEMPLATE DETECTION
-- ============================================================================
-- Automatically detect Django HTML templates and set appropriate filetype
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.html", "*.htm"},
  callback = function()
    local filepath = vim.fn.expand("%:p")
    -- Check if file is in templates directory or contains 'django' in path
    if string.find(filepath, "templates") or string.find(filepath, "django") then
      vim.bo.filetype = "htmldjango"  -- Set Django template filetype
    end
  end,
  desc = "Detect Django HTML templates"
})

-- ============================================================================
-- PYTHON-SPECIFIC SETTINGS
-- ============================================================================
-- Configure Python files according to PEP 8 standards
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4        -- 4 spaces per tab (PEP 8)
    vim.opt_local.shiftwidth = 4     -- 4 spaces per indentation level
    vim.opt_local.expandtab = true   -- Use spaces instead of tabs
    vim.opt_local.textwidth = 88     -- Line length limit (Black formatter default)
  end,
  desc = "Python file settings (PEP 8 compliant)"
})

-- ============================================================================
-- GO-SPECIFIC SETTINGS
-- ============================================================================
-- Configure Go files according to Go conventions
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4         -- 4 spaces per tab display
    vim.opt_local.shiftwidth = 4      -- 4 spaces per indentation level
    vim.opt_local.expandtab = false   -- Go uses tabs, not spaces (Go convention)
    vim.opt_local.textwidth = 120     -- Longer line length for Go
  end,
  desc = "Go file settings (Go conventions)"
})

-- ============================================================================
-- ADDITIONAL UI OPTIONS (COMMENTED)
-- ============================================================================
-- Uncomment to enable cursor line highlighting
-- o.cursorlineopt = 'both'  -- Highlight both line number and text line
