local function spellEnabled()
  if vim.wo.spell then
    return "SPELL"
  else
    return ""
  end
end

local function wordCount()
  return vim.g.wordCountCache
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    -- theme = 'auto',
    theme = require('../core/transparent').theme(),
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode', spellEnabled },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { wordCount, 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
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
