local g = vim.g
local opt = vim.opt

opt.mouse = 'a'
opt.clipboard:append 'unnamedplus'
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.title = true
opt.number = true
opt.relativenumber = true
opt.wildmode = 'longest,list,full'
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true
opt.splitbelow = true
opt.splitright = true
opt.background = 'dark'
opt.cursorline = false
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.wrap = true
opt.visualbell = true
opt.formatoptions = 'qrn1'
opt.backspace = 'indent,eol,start'
opt.matchpairs:append '<:>'
opt.hidden = true
opt.laststatus = 2
opt.updatetime = 50
opt.completeopt = "menu,menuone,noselect"
opt.showbreak = ">>"
opt.breakindent = true
g.termdebug_wide = 163
opt.nrformats = "alpha,octal,bin,hex,unsigned"
opt.scrolloff = 8

vim.api.nvim_command('syntax on')
-- opt.statusline='%m\ %F\ %y\ %{&fileencoding?&fileencoding:&encoding}\ %=%(C:%c\ L:%l\ %P%)'

vim.cmd([[
let g:clipboard = {
      \   'name': 'xsel_override',
      \   'copy': {
      \      '+': 'xsel --input --clipboard',
      \      '*': 'xsel --input --primary',
      \    },
      \   'paste': {
      \      '+': 'xsel --output --clipboard',
      \      '*': 'xsel --output --primary',
      \   },
      \   'cache_enabled': 1,
      \ }
]])
