local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function TrimWhiteSpace()
  local save = vim.fn.winsaveview()
  vim.cmd([[
  keeppatterns %s/\s\+$//e
  keeppatterns %s/\(\n\s*\)\+\%$//e
  ]])
  vim.fn.winrestview(save)
end

augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

augroup('CustomLSP', { clear = true })

augroup('BuildSystems', { clear = true })
autocmd('BufEnter', {
  group = 'BuildSystems',
  pattern = '*.rs',
  command = 'set makeprg=cargo\\ build\\ $*'
})
autocmd('BufEnter', {
  group = 'BuildSystems',
  pattern = '*.pl',
  command = 'let b:repl_name="swipl %"'
})
autocmd('BufEnter', {
  group = 'BuildSystems',
  pattern = '*.py',
  command = 'let b:repl_name="python"'
})

augroup('NumberToggle', { clear = true })
autocmd({'BufEnter','FocusGained','InsertLeave','WinEnter'}, {
  group = 'NumberToggle',
  pattern = '*',
  command = 'if &nu && mode() != "i" | set rnu   | endif'
})

autocmd({'BufLeave','FocusLost','InsertEnter','WinLeave'}, {
  group = 'NumberToggle',
  pattern = '*',
  command = 'if &nu                  | set nornu | endif'
})

--[[ autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\s\\+$//e'
})

autocmd('BufWritePre', {
  pattern = '*',
  command = '%s/\\(\\n\\s*\\)*\\%$//e'
}) ]]

autocmd('BufWritePre', {
  pattern = '*',
  callback = TrimWhiteSpace
})

autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'yaml', 'lua', 'haskell', 'bib' },
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

augroup('Murmur', {clear = true})
autocmd('CursorHold', {
  group = 'Murmur',
  pattern = '*',
  callback = function ()
        -- skip when a float-win already exists.
        if vim.w.diag_shown then return end

        -- open float-win when hovering on a cursor-word.
        if vim.w.cursor_word ~= '' then
          vim.diagnostic.open_float(nil, {
            focusable = true,
            close_events = { 'InsertEnter', 'User CloseFloatWin' },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          })
          vim.w.diag_shown = true
        end
      end
})
