local function spellEnabled()
  if vim.wo.spell then
    if vim.o.spelllang == "en_us" then
      return "ENGLISH"
    else
      return "SPELL"
    end
  else
    return ""
  end
end

local function wordCount()
  return vim.g.wordCountCache
end

local function charFiller()
  if vim.fn.winnr() ~= vim.fn.winnr('j') then
    vim.opt_local.fillchars:append 'stlnc:─'
    vim.opt_local.fillchars:append 'stl:─'
  else
    vim.opt_local.fillchars:append 'stlnc: '
    vim.opt_local.fillchars:append 'stl: '
  end
  return ""
end

local function tabspace()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
    return 'MI:' .. mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
  local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:' .. tab_indent
  else
    return 'MI:' .. space_indent
  end
end

local active_col = { fg = '#cdd6f4' }
local inactive_col = { fg = '#7f849c' }

require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = 'auto',
    theme = "catppuccin", --require('../core/transparent').theme(),
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode', spellEnabled },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { {
      'fileformat',
      icons_enabled = true,
      symbols = {
        unix = 'LF',
        dos = 'CRLF',
        mac = 'CR',
      },
    }, 'filename', charFiller },
    lualine_x = { wordCount, 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location', tabspace }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { charFiller, { 'filename', color = { fg = '#7f849c' } } },
    lualine_x = { { 'location', color = { fg = '#7f849c' } } },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = { 'branch' },
    lualine_c = { 'buffers' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}

}
