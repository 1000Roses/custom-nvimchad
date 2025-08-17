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

-- Generate Python docstrings automatically
map("n", "<leader>pd", ":Pydocstring<CR>", { desc = "Generate Python docstring" })

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
-- ADDITIONAL SHORTCUTS (COMMENTED)
-- ============================================================================
-- Uncomment to enable Ctrl+S for saving in all modes
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
