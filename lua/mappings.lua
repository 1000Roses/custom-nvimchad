-- ============================================================================
-- CUSTOM KEYMAPS AND SHORTCUTS
-- ============================================================================
-- This file contains all custom keybindings for enhanced productivity
-- It extends NvChad's default mappings with language-specific and workflow shortcuts

-- Load NvChad's default mappings first
require "nvchad.mappings"

-- ============================================================================
-- KEYMAP SETUP
-- ============================================================================
local map = vim.keymap.set

-- ============================================================================
-- GENERAL EDITOR SHORTCUTS
-- ============================================================================
-- Quick command mode access
map("n", ";", ":", { desc = "CMD enter command mode" })
-- Quick escape from insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Character navigation shortcuts
-- 'b' + character: go backward to character (similar to 't' for forward)
map("n", "b", function()
  local char = vim.fn.getchar()
  if char then
    local char_str = vim.fn.nr2char(char)
    vim.cmd("normal! F" .. char_str)
  end
end, { desc = "Go backward to character" })

-- ============================================================================
-- LSP (LANGUAGE SERVER PROTOCOL) KEYMAPS
-- ============================================================================
-- Navigation and code intelligence shortcuts using native LSP functions
local opts = { noremap = true, silent = true }

-- Code navigation
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)        -- Find all references
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)    -- Go to implementation
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)       -- Go to declaration
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)        -- Go to definition
map("n", "gp", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)         -- Go to definition (alternative)

-- Code actions and refactoring
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Show available code actions
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)    -- Smart rename symbol

-- Diagnostics and documentation
map("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Show line diagnostics
map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Show cursor diagnostics
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)       -- Previous diagnostic
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)       -- Next diagnostic
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)              -- Show hover documentation

-- ============================================================================
-- WINDOW MANAGEMENT KEYMAPS
-- ============================================================================
-- Shortcuts for splitting and managing windows
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split window" })
map("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Maximize current split window" })

-- Fix for explorer after maximizing - restore before toggling explorer
map("n", "<leader>e", function()
  -- If maximizer is active, restore first
  if vim.t.maximizer_sizes then
    vim.cmd("MaximizerToggle")
  end
  -- Then toggle the file explorer
  vim.cmd("NvimTreeToggle")
end, { desc = "Toggle file explorer (restore maximizer first)" })

-- ============================================================================
-- TAB MANAGEMENT KEYMAPS
-- ============================================================================
-- Shortcuts for creating and navigating tabs
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- ============================================================================
-- DJANGO DEVELOPMENT SHORTCUTS
-- ============================================================================
-- Common Django management commands for rapid development
map("n", "<leader>dm", "<cmd>!python manage.py makemigrations<CR>", { desc = "Django makemigrations" })
map("n", "<leader>dM", "<cmd>!python manage.py migrate<CR>", { desc = "Django migrate" })
map("n", "<leader>dr", "<cmd>split | terminal python manage.py runserver<CR>", { desc = "Django runserver in terminal" })
map("n", "<leader>dR", function()
  -- Close any existing terminal buffers running Django
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match("term://.*python.*manage%.py.*runserver") then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
  -- Kill existing Django server processes
  vim.cmd("!pkill -f 'python.*manage.py.*runserver' 2>/dev/null || true")
  -- Wait a moment for the process to fully terminate
  vim.cmd("!sleep 2")
  -- Kill any process using port 8000 (default Django port)
  vim.cmd("!lsof -ti:8000 | xargs kill -9 2>/dev/null || true")
  vim.cmd("split | terminal python manage.py runserver")
end, { desc = "Django restart server" })
map("n", "<leader>ds", "<cmd>!python manage.py shell<CR>", { desc = "Django shell" })
map("n", "<leader>dt", "<cmd>!python manage.py test<CR>", { desc = "Django test" })
map("n", "<leader>dc", "<cmd>!python manage.py collectstatic<CR>", { desc = "Django collectstatic" })
map("n", "<leader>dsu", "<cmd>!python manage.py createsuperuser<CR>", { desc = "Django create superuser" })

-- ============================================================================
-- DATABASE AND DOCUMENTATION TOOLS
-- ============================================================================
-- Toggle database UI for database management
map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })



-- ============================================================================
-- GO DEVELOPMENT SHORTCUTS
-- ============================================================================
-- Go-specific commands for building, testing, and code quality
map("n", "<leader>gr", "<cmd>GoRun<CR>", { desc = "Go run current file" })
map("n", "<leader>gb", "<cmd>GoBuild<CR>", { desc = "Go build project" })
map("n", "<leader>gt", "<cmd>GoTest<CR>", { desc = "Go test package" })
map("n", "<leader>gT", "<cmd>GoTestFunc<CR>", { desc = "Go test current function" })
map("n", "<leader>gc", "<cmd>GoCoverage<CR>", { desc = "Go test coverage" })
map("n", "<leader>gf", "<cmd>GoFmt<CR>", { desc = "Go format code" })
map("n", "<leader>gi", "<cmd>GoImport<CR>", { desc = "Go organize imports" })
map("n", "<leader>gd", "<cmd>GoDoc<CR>", { desc = "Go show documentation" })
map("n", "<leader>gl", "<cmd>GoLint<CR>", { desc = "Go lint code" })
map("n", "<leader>gv", "<cmd>GoVet<CR>", { desc = "Go vet (static analysis)" })

-- ============================================================================
-- ERROR NAVIGATION AND QUICK FIXES
-- ============================================================================
-- Enhanced error navigation with quick access to definitions and implementations
map("n", "<leader>ed", function()
  -- Go to definition from error location
  vim.lsp.buf.definition()
end, { desc = "Go to definition from error" })

map("n", "<leader>ei", function()
  -- Go to implementation from error location
  vim.lsp.buf.implementation()
end, { desc = "Go to implementation from error" })

map("n", "<leader>ef", function()
  -- Show error details and quick fix options
  vim.diagnostic.open_float()
  vim.defer_fn(function()
    vim.lsp.buf.code_action()
  end, 100)
end, { desc = "Show error details and quick fixes" })

map("n", "<leader>er", function()
  -- Go to references from error location
  vim.lsp.buf.references()
end, { desc = "Go to references from error" })

-- Quick error navigation
map("n", "<leader>en", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next error" })
map("n", "<leader>ep", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous error" })
map("n", "<leader>el", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "List all errors" })

-- ============================================================================
-- FUNCTION NAME DISPLAY
-- ============================================================================
map("n", "<leader>fn", function()
  local winbar_enabled = vim.g.winbar_function_enabled
  if winbar_enabled == nil then winbar_enabled = true end
  
  vim.g.winbar_function_enabled = not winbar_enabled
  
  if vim.g.winbar_function_enabled then
    require("configs.winbar").setup()
    print("Function name display enabled")
  else
    vim.wo.winbar = nil
    print("Function name display disabled")
  end
end, { desc = "Toggle file name and function display in winbar" })

-- ============================================================================
-- TELESCOPE SEARCH SHORTCUTS
-- ============================================================================
-- File search with <space>ff
map("n", "<space>ff", function()
  require('telescope.builtin').find_files()
end, { desc = "Find files" })

-- Text search with <space>fs
map("n", "<space>fs", function()
  require('telescope.builtin').live_grep()
end, { desc = "Search text in files" })

-- ============================================================================
-- DEBUGGING (DAP) SHORTCUTS
-- ============================================================================
-- Toggle breakpoint
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

-- Set conditional breakpoint
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set conditional breakpoint" })

-- Continue debugging
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue debugging" })

-- Step over
map("n", "<leader>ds", function()
  require("dap").step_over()
end, { desc = "Step over" })

-- Step into
map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step into" })

-- Step out
map("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step out" })

-- Open REPL
map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })

-- Run last debug session
map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run last debug session" })

-- Terminate debug session
map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Terminate debug session" })

-- Toggle debug UI
map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle debug UI" })

-- Evaluate expression
map("n", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Evaluate expression" })

-- Evaluate selection in visual mode
map("v", "<leader>de", function()
  require("dapui").eval()
end, { desc = "Evaluate selection" })

-- Telescope-specific keymaps for search input
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    local opts = { buffer = true, silent = true }
    -- Cmd+A to select all in telescope search
    vim.keymap.set("i", "<D-a>", "<C-a>", opts)
    -- Alternative: Ctrl+A to select all
    vim.keymap.set("i", "<C-a>", "<C-a>", opts)
  end,
})

-- ============================================================================
-- ADDITIONAL SHORTCUTS (COMMENTED)
-- ============================================================================
-- Uncomment to enable Ctrl+S for saving in all modes
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
