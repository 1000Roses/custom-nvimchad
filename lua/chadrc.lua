-- ============================================================================
-- NVCHAD CONFIGURATION (chadrc.lua)
-- ============================================================================
-- This file configures NvChad-specific settings including themes, UI elements,
-- and dashboard options. It follows the structure defined in nvconfig.lua
-- Reference: https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- ============================================================================
-- THEME CONFIGURATION
-- ============================================================================
M.base46 = {
	-- Set the color scheme to OneDark theme
	theme = "onedark",

	-- Highlight overrides for custom styling (currently disabled)
	-- Uncomment to enable italic comments
	-- hl_override = {
	-- 	Comment = { italic = true },           -- Make regular comments italic
	-- 	["@comment"] = { italic = true },      -- Make treesitter comments italic
	-- },
}

-- ============================================================================
-- DASHBOARD CONFIGURATION (DISABLED)
-- ============================================================================
-- Uncomment to enable NvDash (dashboard) on startup
-- M.nvdash = { load_on_startup = true }

-- ============================================================================
-- UI CONFIGURATION (DISABLED)
-- ============================================================================
-- Uncomment to configure tabufline behavior
-- M.ui = {
--       tabufline = {
--          lazyload = false    -- Disable lazy loading for tab buffer line
--      }
-- }

return M
