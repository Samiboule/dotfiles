local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local command = vim.api.nvim_create_user_command

vim.g.mapleader = " "
vim.g.maplocalleader = ","

map('n', 'c', '"_c')

map('n', '<TAB>', '>>')
map('n', '<S-TAB>', '<<')
map('v', '<TAB>', '>gv')
map('v', '<S-TAB>', '<gv')
map('v', '>', '>gv')
map('v', '<', '<gv')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<Esc>', ':noh<CR>')

map('n', '<F6>', ':setlocal spell! spelllang=en_us<CR>"', { silent = false })

map('n', '<leader>bn', ':bn<CR>')
map('n', '<leader>tn', 'gt')

map('t', '<Esc', '<C-\\><C-n>')

map('i', "<C-l>", '<c-g>u<Esc>[s1z=`]a<c-g>u')

command('Config', ':e $MYVIMRC', {})

command('W', ':execute ":silent w !sudo tee % > /dev/null" | :edit!', {})
