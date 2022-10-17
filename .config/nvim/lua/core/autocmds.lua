local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e'
})

autocmd('BufwritePre', {
  pattern = '*',
  command = '%s/\\(\\n\\s*\\)*\\%$//e'
})

autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'yaml', 'lua', 'haskell' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

autocmd('BufWritePost', {
  pattern = '*.tex',
  command = ':silent let g:wordCountCache = vimtex#misc#wordcount()'
})

-- augroup('reloadVimrc' { clear = true })

augroup('Mkdir', { clear = true })
autocmd('BufWritePre', {
  pattern = '*',
  command = 'call mkdir(expand("<afile>:p:h"), "p")'
})
