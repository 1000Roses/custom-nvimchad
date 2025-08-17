-- ============================================================================
-- AUTOCOMMANDS AND EVENT HANDLERS
-- ============================================================================
-- This file contains automatic commands that respond to various Neovim events
-- It extends NvChad's default autocommands with custom event handling

-- Load NvChad's default autocommands first
require "nvchad.autocmds"

-- ============================================================================
-- CUSTOM AUTOCOMMANDS
-- ============================================================================

-- Auto-formatting after 2 seconds of inactivity for Go and Python files
local format_timer = nil

local function setup_auto_format()
  local augroup = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
  
  -- Clear existing timer and create new one on text changes
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = augroup,
    pattern = { "*.go", "*.py" },
    callback = function()
      -- Clear existing timer if it exists
      if format_timer then
        vim.fn.timer_stop(format_timer)
      end
      
      -- Create new timer for 2 seconds
      format_timer = vim.fn.timer_start(2000, function()
        -- Only format if we're still in the same buffer and it's a Go/Python file
        local current_file = vim.fn.expand("%:e")
        if current_file == "go" or current_file == "py" then
          -- Use conform.nvim for formatting
          local conform = require("conform")
          if conform then
            conform.format({ async = true, lsp_fallback = true })
          end
        end
        format_timer = nil
      end)
    end,
  })
  
  -- Clear timer when leaving buffer to prevent formatting wrong file
  vim.api.nvim_create_autocmd("BufLeave", {
    group = augroup,
    pattern = { "*.go", "*.py" },
    callback = function()
      if format_timer then
        vim.fn.timer_stop(format_timer)
        format_timer = nil
      end
    end,
  })
end

-- Initialize auto-formatting
setup_auto_format()

-- Note: Most language-specific autocommands are defined in options.lua
-- for better organization and maintainability