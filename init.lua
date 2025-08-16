-- ============================================================================
-- NEOVIM CONFIGURATION ENTRY POINT
-- ============================================================================
-- This is the main configuration file that bootstraps the entire Neovim setup
-- It handles plugin management, theme loading, and module initialization

-- Set up Base46 theme cache directory for faster theme loading
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

-- Set the leader key to space for custom keymaps
vim.g.mapleader = " "

-- ============================================================================
-- LAZY.NVIM PLUGIN MANAGER BOOTSTRAP
-- ============================================================================
-- Automatically install lazy.nvim plugin manager if not present
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  -- Clone lazy.nvim from GitHub with minimal download (blob:none filter)
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- Add lazy.nvim to the runtime path so it can be required
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim configuration settings
local lazy_config = require "configs.lazy"

-- ============================================================================
-- PLUGIN SETUP AND LOADING
-- ============================================================================
-- Initialize lazy.nvim with plugin specifications
require("lazy").setup({
  {
    -- Load NvChad base configuration and plugins
    "NvChad/NvChad",
    lazy = false,           -- Load immediately, not lazily
    branch = "v2.5",        -- Use stable v2.5 branch
    import = "nvchad.plugins", -- Import all NvChad default plugins
  },

  -- Import custom plugins from lua/plugins/ directory
  { import = "plugins" },
}, lazy_config)

-- ============================================================================
-- THEME AND UI INITIALIZATION
-- ============================================================================
-- Load Base46 theme defaults and statusline configuration
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- ============================================================================
-- CONFIGURATION MODULE LOADING
-- ============================================================================
-- Load core configuration modules in order
require "options"    -- Editor options and settings
require "autocmds"   -- Autocommands and event handlers

-- Schedule mappings to load after other configurations are complete
vim.schedule(function()
  require "mappings"  -- Custom keymaps and shortcuts
end)
