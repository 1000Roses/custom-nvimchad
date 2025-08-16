-- ============================================================================
-- CONFORM.NVIM FORMATTER CONFIGURATION
-- ============================================================================
-- This file configures code formatters for different file types
-- Conform.nvim provides a unified interface for various formatting tools

local options = {
  -- ============================================================================
  -- FORMATTERS BY FILE TYPE
  -- ============================================================================
  formatters_by_ft = {
    -- Lua formatting using StyLua
    lua = { "stylua" },
    
    -- Web development formatters (disabled by default)
    -- Uncomment to enable Prettier for CSS and HTML
    -- css = { "prettier" },
    -- html = { "prettier" },
    
    -- Additional formatters can be added here:
    -- python = { "black", "isort" },     -- Python: Black + isort
    -- go = { "gofumpt", "goimports" },   -- Go: gofumpt + goimports
    -- javascript = { "prettier" },       -- JavaScript: Prettier
    -- typescript = { "prettier" },       -- TypeScript: Prettier
    -- json = { "prettier" },             -- JSON: Prettier
  },

  -- ============================================================================
  -- FORMAT ON SAVE CONFIGURATION (DISABLED)
  -- ============================================================================
  -- Uncomment to enable automatic formatting when saving files
  -- format_on_save = {
  --   timeout_ms = 500,      -- Maximum time to wait for formatting
  --   lsp_fallback = true,   -- Use LSP formatter if conform formatter unavailable
  -- },
}

return options
