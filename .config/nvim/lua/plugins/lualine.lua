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
    lualine_c = { 'filename', charFiller },
    lualine_x = { wordCount, 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
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
