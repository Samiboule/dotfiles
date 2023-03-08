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

map('v', '>', '>gv')
map('v', '<', '<gv')

map('n', '<A-j>', ':m .+1<CR>==')
map('n', '<A-k>', ':m .-2<CR>==')
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
map('v', '<A-j>', ':m \'>+1<CR>gv=gv')
map('v', '<A-k>', ':m \'<-2<CR>gv=gv')

map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<C-w>H', '<C-w>H:lua require("lualine").refresh()<CR>')
map('n', '<C-w>J', '<C-w>J:lua require("lualine").refresh()<CR>')
map('n', '<C-w>K', '<C-w>K:lua require("lualine").refresh()<CR>')
map('n', '<C-w>L', '<C-w>L:lua require("lualine").refresh()<CR>')
map('n', '<C-w>r', '<C-w>r:lua require("lualine").refresh()<CR>')
map('n', '<C-w>R', '<C-w>R:lua require("lualine").refresh()<CR>')
map('n', '<C-w>x', '<C-w>x:lua require("lualine").refresh()<CR>')
map('n', '<C-w>X', '<C-w>X:lua require("lualine").refresh()<CR>')

map('n', '<Esc>', ':noh<CR>')

map('n', '<F6>', ':setlocal spell! spelllang=en_us<CR>', { silent = false })

map('n', '<leader>b', '<cmd>lua require("fzf-lua").buffers()<CR>')
map('n', '<leader><leader>', '<cmd>lua require("fzf-lua").files()<CR>')
map('n', '<leader>j', '<cmd>lua require("fzf-lua").lsp_document_symbols()<CR>')
map('n', '<leader>s', '<cmd>lua require("fzf-lua").live_grep()<CR>')

map('n', '<leader>v', ':setlocal ve=all<CR>')
map('n', '<leader>u', ':setlocal ve=""<CR>')

map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')

map('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

command('Config', ':e $MYVIMRC', {})

command('W', ':execute ":silent w !sudo tee % > /dev/null" | :edit!', {})
