-- ============================================================================
-- WINBAR CONFIGURATION FOR FUNCTION NAME DISPLAY
-- ============================================================================
-- This configuration adds a winbar that shows the current function name
-- using treesitter to parse the code structure

local M = {}

-- Function to get current function name using treesitter
local function get_current_function()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local parsers = require('nvim-treesitter.parsers')
  
  -- Check if treesitter is available for current buffer
  if not parsers.has_parser() then
    return nil
  end
  
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return nil
  end
  
  -- Walk up the tree to find function nodes
  local function_node = current_node
  while function_node do
    local node_type = function_node:type()
    
    -- Check for different function node types across languages
    if node_type == 'function_declaration' or 
       node_type == 'function_definition' or
       node_type == 'method_declaration' or
       node_type == 'method_definition' or
       node_type == 'function_item' or
       node_type == 'method_spec' or
       node_type == 'function_literal' or
       node_type == 'arrow_function' or
       node_type == 'function_expression' then
      
      -- Try to get function name from different child nodes
      for child in function_node:iter_children() do
        local child_type = child:type()
        if child_type == 'identifier' or 
           child_type == 'field_identifier' or
           child_type == 'property_identifier' then
          local name = vim.treesitter.get_node_text(child, 0)
          if name and name ~= '' then
            return name
          end
        end
      end
      
      -- Fallback: return generic function indicator
      return '<function>'
    end
    
    function_node = function_node:parent()
  end
  
  return nil
end

-- Function to create winbar content
local function create_winbar()
  local function_name = get_current_function()
  local file_name = vim.fn.expand('%:t')  -- Get current file name
  
  local winbar_content = ""
  
  -- Add file name if available
  if file_name and file_name ~= '' then
    winbar_content = "%#WinBarFile# " .. file_name .. " %*"
  end
  
  -- Add function name if available
  if function_name then
    if winbar_content ~= "" then
      winbar_content = winbar_content .. " %#WinBarSeparator#→%* "
    end
    winbar_content = winbar_content .. "%#WinBarFunction# " .. function_name .. " %*"
  end
  
  return winbar_content
end

-- Set up winbar
function M.setup()
  -- Create highlight groups for winbar elements
  vim.api.nvim_set_hl(0, 'WinBarFile', {
    fg = '#e06c75',  -- Red color for file name
    bg = 'NONE',
    bold = true
  })
  
  vim.api.nvim_set_hl(0, 'WinBarFunction', {
    fg = '#61afef',  -- Blue color for function name
    bg = 'NONE',
    bold = true
  })
  
  vim.api.nvim_set_hl(0, 'WinBarSeparator', {
    fg = '#abb2bf',  -- Gray color for separator
    bg = 'NONE',
    bold = false
  })
  
  -- Set up autocommand to update winbar
  local winbar_group = vim.api.nvim_create_augroup('WinBarFunction', { clear = true })
  
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
    group = winbar_group,
    callback = function()
      -- Check if winbar is enabled
      local winbar_enabled = vim.g.winbar_function_enabled
      if winbar_enabled == nil then winbar_enabled = true end
      
      if not winbar_enabled then
        vim.wo.winbar = nil
        return
      end
      
      -- Only show winbar for code files
      local ft = vim.bo.filetype
      if ft == '' or ft == 'help' or ft == 'terminal' or ft == 'NvimTree' then
        vim.wo.winbar = nil
        return
      end
      
      vim.wo.winbar = create_winbar()
    end,
  })
end

return M