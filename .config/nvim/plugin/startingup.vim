fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

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

    " Now we can just write to the buffer, whatever you want.
    " call append('$', " ____                  _   _        _   _                 _           ")
    " call append('$', "/ ___|  __ _ _ __ ___ (_) ( )___   | \\ | | ___  _____   _(_)_ __ ___  ")
    " call append('$', "\\___ \\ / _` | '_ ` _ \\| | |// __|  |  \\| |/ _ \\/ _ \\ \\ / / | '_ ` _ \\ ")
    " call append('$', " ___) | (_| | | | | | | |   \\__ \\  | |\\  |  __/ (_) \\ V /| | | | | | |")
    " call append('$', "|____/ \\__,_|_| |_| |_|_|   |___/  |_| \\_|\\___|\\___/ \\_/ |_|_| |_| |_|")
    call append('$', "")
    call append('$', "⣿⣿⡆⠀⠀⢸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⣾⣿⡆⠀")
    call append('$', "⣿⣿⡇⠀⠀⢸⣿⢰⣿⡆⠀⣾⣿⡆⠀⣾⣷⣿⣿⡇⠀⠀⣿⣿⡇⠀")
    call append('$', "⣿⣿⡇⠀⠀⢸⣿⠘⣿⣿⣤⣿⣿⣿⣤⣿⡇⢻⣿⡇⠀⠀⣿⣿⡇⠀")
    call append('$', "⣿⣿⡇⠀⠀⢸⡿⠀⢹⣿⣿⣿⣿⣿⣿⣿⠁⢸⣿⣇⠀⢀⣿⣿⠇⠀")
    call append('$', "⠙⢿⣷⣶⣶⡿⠁⠀⠈⣿⣿⠟⠀⣿⣿⠇⠀⠈⠻⣿⣶⣾⡿⠋⠀⠀")
    call append('$', "")
    call append('$', "⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⡀⠀⢀⣴⣿⠋⠀⠀⣀⣴⠞⠀⣀⣤⣶⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢀⡞⠁⣰⣿⣿⣿⣀⣤⣾⣿⣏⣴⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣶⣜⢦⡀⠀⠀⠀⠀⠀⠀⠀")
    call append('$', "⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣾⣿⡀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢀⣀⠀⠀⣠⣾⠀⠀⠀⠀⢻⣿⣿⣿⣷⡳⡀⠀⠀⠀⠀⠀⠀")
    call append('$', "⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⣶⣿⡏⣠⣾⣿⣿⢀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣳⠀⠀⠀⠀⠀⠀")
    call append('$', "⠀⠘⣿⢃⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠈⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣇⠀⠀⠀⢸⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⣿⠀⠀⠀⣿⣿⠁⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⢸⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠹⠁⠀⠀⢿⡏⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⢿⣠⠝⣷⠀⠀⠀⠀⠈⠁⠀⠈⣿⣿⣟⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⡿⡄⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣷⡀⠈⠁⢰⠃⣠⣿⠀⠀⠀⠀⠀⠀⠀⣼⠞⠀⢀⣿⡝⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⡏⠃⣇⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⡍⡀⠀⢸⣴⣿⡿⠀⠀⠀⠀⠀⠀⢠⢿⢀⣴⣿⣿⡇⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠁⠀⢸⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⠀⢈⣽⢿⣿⣿⡇⠹⡄⠸⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣧⡽⠃⠀⠀⡙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⢀⣧⠸⡆⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⣰⣿⡷⢫⣿⣿⠇⠀⠙⠢⠔⠚⣠⡄⠀⠀⠀⠀⠀⠀⢦⡙⠛⠉⢀⣀⡤⠎⣠⣾⣿⣟⣋⣙⢿⣿⣿⣿⣿⠀⢸⣿⣿⣀⡇⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠐⢻⣟⢠⣿⣿⡏⠀⠀⠀⠀⠀⠀⢿⣄⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠀⠀⣸⣿⣿⡿⠛⢳⠘⠐⣿⣿⣿⣿⣿⣼⣿⣿⡽⣧⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⠈⠳⣾⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⠏⢱⡞⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⡟⠒⠋⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⠏⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⠷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⣠⣾⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⢤⣀⠀⠀⠀⠀⠀⠈⠑⠲⠤⡤⠖⠒⠒⠒⠋⠉⠉⠁⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀")
    call append('$', "⠀⠀⠀⠀⣀⠴⠚⠁⠀⠀⠀⣨⢧⡀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⡤⠤⣄⡀⠀⠀⠀⠀")
    call append('$', "⠀⠀⣠⠞⠁⠀⠀⢀⣤⡾⠊⠁⡞⠉⠒⠒⠒⣲⠤⡄⢠⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⢀⣀⣀⣀⡠⠤⢴⡶⠊⠉⠀⠀⠀⠀⠹⡄⠀⠀⠀")
    call append('$', "⠀⡼⠁⠀⠀⠀⠀⠙⠉⠀⠀⡼⠀⠀⠀⠀⠀⡟⠒⠼⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣤⠴⠊⠁⠈⠁⠀⢀⣴⠋⠀⠀⠀⠀⠀⠀⠀⢠⠏⠢⡀⠀")
    call append('$', "⢠⠇⠀⠀⠀⡤⠄⠀⠀⠀⢰⠇⠀⠀⠀⠀⠀⢳⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⣀⡠⠔⠋⠁⠀⠀⠀⠀⠀⣠⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢆⠘⡆")
    call append('$', "⢸⠀⠀⠀⡼⠁⠀⠀⢀⡼⡟⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀⠀⠀⢀⣀⠤⠖⠋⠁⠀⠠⣀⠀⠀⠀⠀⣠⢞⡟⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠘⡆⠃")
    call append('$', "⡸⠀⠀⣼⠁⠀⣀⡴⠋⠀⡇⠀⠀⠀⢀⣀⠤⠤⠜⠓⠶⣖⡋⠉⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⣀⡴⣡⠎⣀⡴⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠦⠇⠀")
    %center 166
    " No modifications to this buffer
    setlocal nomodifiable nomodified

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> p :enew <bar> put<CR>
endfun

" Run after "doing all the startup stuff"
autocmd VimEnter * call Start()
