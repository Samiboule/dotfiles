require('colorizer').setup()
require('Comment').setup()
require('nvim-autopairs').setup({disable_in_macro = true, disable_in_visualblock = true})
require('diffview').setup({use_icons = false})
require('eyeliner').setup{highlight_on_key = true}
require('fidget').setup({window = {blend = 0}})
require('satellite').setup({marks = {show_builtins = true}})
require('murmur').setup({
      cursor_rgb = '#395999', -- default to '#393939'
      max_len = 80, -- maximum word-length to highlight
      -- disable_on_lines = 2000, -- to prevent lagging on large files. Default to 2000 lines.
      exclude_filetypes = {},
      callbacks = {
        -- to trigger the close_events of vim.diagnostic.open_float.
        function ()
          -- Close floating diag. and make it triggerable again.
          vim.cmd('doautocmd User CloseFloatWin')
          vim.w.diag_shown = false
        end,
      }})
require('gitsigns').setup()
