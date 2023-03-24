local s = require('startupscreens')

local M = {}

function M.startupfunc()
  local all_screens = {s.necoarc, s.fumo, s.akane, s.smug}
  local return_early = vim.api.nvim_exec([[
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we've started in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        echo 0
      else
        echo 1
    endif
  ]], true)

  if return_early == '0' then
    return
  end

  vim.cmd([[
    " Start a new buffer ...
    enew

    " ... and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber
        \ nowrap
  ]])

  -- Now we can just write to the buffer
  all_screens[ math.random( #all_screens ) ]()
  vim.cmd([[
    execute '%center ' . winwidth(0)
    " No modifications to this buffer
    setlocal nomodifiable nomodified

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> p :enew <bar> put<CR>
  ]])
end

return M
