-- ============================================================================
-- LAZY.NVIM PLUGIN MANAGER CONFIGURATION
-- ============================================================================
-- This file configures the lazy.nvim plugin manager settings
-- It controls plugin loading behavior, UI appearance, and performance optimizations

return {
  -- ============================================================================
  -- PLUGIN LOADING DEFAULTS
  -- ============================================================================
  defaults = { lazy = true },  -- Load plugins lazily by default for faster startup
  
  -- ============================================================================
  -- INSTALLATION SETTINGS
  -- ============================================================================
  install = { 
    colorscheme = { "nvchad" }  -- Use NvChad colorscheme during plugin installation
  },

  -- ============================================================================
  -- USER INTERFACE CONFIGURATION
  -- ============================================================================
  ui = {
    icons = {
      ft = "",           -- File type icon
      lazy = "󰂠 ",        -- Lazy loading icon
      loaded = "",       -- Plugin loaded icon
      not_loaded = "",   -- Plugin not loaded icon
    },
  },

  -- ============================================================================
  -- PERFORMANCE OPTIMIZATIONS
  -- ============================================================================
  performance = {
    rtp = {
      -- Disable unused Vim plugins to improve startup time
      disabled_plugins = {
        -- HTML conversion plugins
        "2html_plugin",
        "tohtml",
        
        -- Script downloading plugins
        "getscript",
        "getscriptPlugin",
        
        -- Compression plugins
        "gzip",
        "tar",
        "tarPlugin",
        "zip",
        "zipPlugin",
        "vimball",
        "vimballPlugin",
        
        -- File management (replaced by modern alternatives)
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        
        -- Miscellaneous unused plugins
        "logipat",
        "matchit",
        "rrhelper",
        "spellfile_plugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
