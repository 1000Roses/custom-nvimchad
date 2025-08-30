-- ============================================================================
-- PLUGIN CONFIGURATION
-- ============================================================================
-- This file defines all custom plugins and their configurations
-- It extends NvChad's base plugins with development-specific tools

return {
  -- ============================================================================
  -- CODE FORMATTING
  -- ============================================================================
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- Uncomment to enable format on save
    opts = require "configs.conform",
    desc = "Code formatter with support for multiple languages"
  },

  -- ============================================================================
  -- LANGUAGE SERVER PROTOCOL (LSP)
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    desc = "LSP configuration for Python, Go, HTML, CSS and more"
  },

  -- ============================================================================
  -- COMPLETION ENGINE
  -- ============================================================================
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
    desc = "Custom completion configuration with Shift+j/k and arrow key navigation"
  },

  -- ============================================================================
  -- SYNTAX HIGHLIGHTING AND PARSING
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Core Neovim languages
        "vim", "lua", "vimdoc",
        -- Web development
        "html", "css", "json", "yaml", "toml",
        -- Python and Django
        "python", "htmldjango", "sql",
        -- Go development
        "go", "gomod", "gowork", "gotmpl"
      },
    },
    desc = "Advanced syntax highlighting and code parsing"
  },

  -- ============================================================================
  -- PYTHON AND DJANGO DEVELOPMENT
  -- ============================================================================
  {
    "tweekmonster/django-plus.vim",
    ft = { "python", "htmldjango" },
    desc = "Enhanced Django template and Python file support"
  },

  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
    desc = "PEP 8 compliant Python indentation"
  },



  -- ============================================================================
  -- DATABASE MANAGEMENT
  -- ============================================================================
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",        -- Database UI interface
      "kristijanhusak/vim-dadbod-completion", -- SQL completion
    },
    cmd = { "DBUI", "DBUIToggle" },
    desc = "Database interface and management tools"
  },

  -- ============================================================================
  -- VERSION CONTROL
  -- ============================================================================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    desc = "Git integration with line-by-line change indicators"
  },

  -- ============================================================================
  -- WINDOW MANAGEMENT
  -- ============================================================================
  {
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    keys = {
      { "<leader>sm", ":MaximizerToggle<CR>", desc = "Maximize current split window" }
    },
    desc = "Maximize and restore split windows"
  },

  -- ============================================================================
  -- AUTO SAVE
  -- ============================================================================
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      execution_message = {
        enabled = true,
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
        cancel_defered_save = { "InsertEnter" },
      },
      condition = function(buf)
        local fn = vim.fn
        
        -- Don't save if buffer is not modifiable, readonly, or special filetype
        if fn.getbufvar(buf, "&modifiable") == 1 and
           fn.getbufvar(buf, "&readonly") == 0 and
           fn.getbufvar(buf, "&buftype") == "" and
           fn.bufname(buf) ~= "" then
          local filetype = fn.getbufvar(buf, "&filetype")
          local excluded_filetypes = { "oil", "alpha", "dashboard", "neo-tree", "Trouble", "trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm" }
          for _, ft in ipairs(excluded_filetypes) do
            if filetype == ft then
              return false
            end
          end
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 2000,  -- 2 seconds delay
    },
    desc = "Automatic file saving after 2 seconds of inactivity"
  },

  -- ============================================================================
  -- SURROUND - Text Object Manipulation
  -- ============================================================================
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
          change_line = "cS",
        },
      })
    end,
    desc = "Add/change/delete surrounding delimiter pairs with ease"
  },

  -- ============================================================================
  -- MULTI-CURSOR - Multiple Selection and Editing
  -- ============================================================================
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      -- Set up key mappings before plugin loads
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",              -- Find next occurrence (like VS Code)
        ["Find Subword Under"] = "<C-n>",      -- Find next subword
        ["Select All"] = "<C-S-l>",            -- Select all occurrences
        ["Start Regex Search"] = "<C-/>",      -- Start regex search
        ["Add Cursor Down"] = "<C-S-j>",       -- Add cursor below
        ["Add Cursor Up"] = "<C-S-k>",         -- Add cursor above
        ["Skip Region"] = "<C-x>",             -- Skip current and find next
        ["Remove Region"] = "<C-p>",           -- Remove current selection
      }
      
      -- Additional settings
      vim.g.VM_theme = "iceblue"               -- Color theme for cursors
      vim.g.VM_highlight_matches = "underline" -- Highlight style for matches
      vim.g.VM_silent_exit = 1                 -- Don't show messages when exiting
    end,
    desc = "Multiple cursors and selections with Ctrl+N (VS Code-like)"
  },

  -- ============================================================================
  -- TROUBLE - Diagnostics and Error Management
  -- ============================================================================
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {
      modes = {
         diagnostics = {
              mode = "diagnostics",
              win = {
                position = "bottom",
                size = { height = 10 },
              },
             filter = function(items)
               local seen = {}
               local filtered = {}
               for _, item in ipairs(items) do
                 if item.severity == vim.diagnostic.severity.ERROR then
                   local key = item.filename .. ":" .. item.message
                   if not seen[key] then
                     seen[key] = true
                     table.insert(filtered, item)
                   end
                 end
               end
               return filtered
             end,
             format = "{message} - {filename}:{lnum}",
             sort = { "severity", "filename", "lnum" },
           },
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
      focus = false,
      follow = false,
      indent_guides = true,
      max_items = 200,
      multiline = true,
      pinned = false,
      warn_no_results = false,
      open_no_results = false,
    },
    desc = "Beautiful diagnostics list for LSP errors, warnings, and issues"
  },

  -- ============================================================================
  -- FLOATING TERMINAL - Centered Terminal in Box
  -- ============================================================================
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      {
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "Toggle floating terminal",
      },
      {
        "<leader>th",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        desc = "Toggle horizontal terminal",
      },
      {
        "<leader>tv",
        "<cmd>ToggleTerm direction=vertical size=80<cr>",
        desc = "Toggle vertical terminal",
      },
      {
        "<C-\\>",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "Toggle floating terminal",
        mode = { "n", "t" },
      },
      {
        "<C-t>",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "Toggle floating terminal",
        mode = { "n", "t" },
      },
    },
    opts = {
      size = 20,
      open_mapping = [[<C-\\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 0,
        zindex = 1000,
        title_pos = "center",
      },
      winbar = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      
      -- Set terminal keymaps
      function _G.set_terminal_keymaps()
        local opts_term = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\\><C-n>]], opts_term)
        vim.keymap.set('t', 'jk', [[<C-\\><C-n>]], opts_term)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts_term)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts_term)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts_term)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts_term)
        vim.keymap.set('t', '<C-w>', [[<C-\\><C-n><C-w>]], opts_term)
      end
      
      -- Apply terminal keymaps when terminal opens
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
    desc = "Floating terminal that appears in center with rounded borders"
  },

  -- ============================================================================
  -- GO DEVELOPMENT
  -- ============================================================================
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",              -- GUI library for go.nvim
      "neovim/nvim-lspconfig",         -- LSP integration
      "nvim-treesitter/nvim-treesitter", -- Syntax highlighting
    },
    config = function()
      require("go").setup({
        -- Disable go.nvim's LSP setup to prevent conflicts with lspconfig
        lsp_cfg = false,
        lsp_gofumpt = false,
        lsp_on_attach = false,
        -- Keep other useful features
        dap_debug = true,
        dap_debug_gui = true,
        test_runner = 'go',
        run_in_floaterm = false,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},              -- Load for Go files
    build = ':lua require("go.install").update_all_sync()', -- Auto-install Go tools
    desc = "Comprehensive Go development tools and utilities"
  },

  -- ============================================================================
  -- DEBUGGING (DAP - Debug Adapter Protocol)
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Setup DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })
      
      -- Setup virtual text
      require("nvim-dap-virtual-text").setup()
      
      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    desc = "Debug Adapter Protocol for debugging with breakpoints and UI"
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      
      -- Add Django-specific debug configurations
      local dap = require("dap")
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django: Debug Server",
        program = vim.fn.getcwd() .. "/manage.py",
        args = { "runserver", "--noreload" },
        django = true,
        justMyCode = false,
        console = "integratedTerminal",
      })
      
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django: Debug Tests",
        program = vim.fn.getcwd() .. "/manage.py",
        args = { "test" },
        django = true,
        justMyCode = false,
        console = "integratedTerminal",
      })
      
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Django: Debug Management Command",
        program = vim.fn.getcwd() .. "/manage.py",
        args = function()
          local command = vim.fn.input("Management command: ")
          return vim.split(command, " ")
        end,
        django = true,
        justMyCode = false,
        console = "integratedTerminal",
      })
      
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Django: Attach to Running Server",
        connect = {
          host = "127.0.0.1",
          port = 5678,
        },
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(),
            remoteRoot = ".",
          },
        },
        django = true,
        justMyCode = false,
      })
    end,
    desc = "Python debugging support with debugpy"
  },

  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-go").setup()
    end,
    desc = "Go debugging support with delve"
  },

  -- ============================================================================
  -- EXPERIMENTAL FEATURES (DISABLED)
  -- ============================================================================
  -- Uncomment to test new completion engine
  -- { import = "nvchad.blink.lazyspec" },
}
