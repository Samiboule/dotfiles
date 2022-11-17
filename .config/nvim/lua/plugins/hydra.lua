local Hydra = require("hydra")

local diagramhint = [[
 Arrow^^^^^^   Select region with <C-v>
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_
 ^ ^ _J_ ^ ^                      _<Esc>_
]]

Hydra({
   name = 'Draw Diagram',
   hint = diagramhint,
   config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
      on_enter = function()
         vim.o.virtualedit = 'all'
      end,
   },
   mode = 'n',
   body = '<leader>d',
   heads = {
      { 'H', '<C-v>h:VBox<CR>' },
      { 'J', '<C-v>j:VBox<CR>' },
      { 'K', '<C-v>k:VBox<CR>' },
      { 'L', '<C-v>l:VBox<CR>' },
      { 'f', ':VBox<CR>', { mode = 'v' }},
      { 'F', ':VFill<CR>', { mode = 'v' }},
      { '<Esc>', nil, { exit = true } },
   }
})

local windowhint = [[
  ^ ^ Move      ^^^^^Positioning   ^^^^^^Split
^^------------- ^^^^^----------- ^^^^^^---------
^    _<C-k>_ ^       _r_ _K_ _R_    ^ ^   _k_     ^^_s_: horizontally
 _<C-h>_ _<C-l>_     _H_ ^ ^ _L_      _h_ ^ ^ _l_   _v_: vertically
^    _<C-j>_ ^       _x_ _J_ _X_    ^ ^   _j_     ^^_Q_, _<C-q>_: close
    ^^focus       ^^^^^windows _e_: equalize ^^^^^^^_o_: remain only
]]

Hydra({
	name = "Change / Resize Window",
  hint = windowhint,
	mode = { "n" },
	body = "<C-q>",
	config = {
		-- color = "pink",
      hint = {
         border = 'rounded'
      },
    invoke_on_body = true,
	},
	heads = {
		-- move between windows
		{ "<C-h>", "<C-w>h" },
		{ "<C-j>", "<C-w>j" },
		{ "<C-k>", "<C-w>k" },
		{ "<C-l>", "<C-w>l" },

		-- resizing windows
		{ "h", "<C-w>3<" },
		{ "l", "<C-w>3>" },
		{ "k", "<C-w>2+" },
		{ "j", "<C-w>2-" },

		-- moving windows
		{ "H", "<C-w>H:lua require('lualine').refresh()<CR>" },
		{ "J", "<C-w>J:lua require('lualine').refresh()<CR>" },
		{ "K", "<C-w>K:lua require('lualine').refresh()<CR>" },
		{ "L", "<C-w>L:lua require('lualine').refresh()<CR>" },
		{ "r", "<C-w>r:lua require('lualine').refresh()<CR>" },
		{ "R", "<C-w>R:lua require('lualine').refresh()<CR>" },
		{ "x", "<C-w>x:lua require('lualine').refresh()<CR>" },
		{ "X", "<C-w>X:lua require('lualine').refresh()<CR>" },

    -- create splits
    { "s", "<C-w>s"},
    { "v", "<C-w>v"},

    -- remain only
    { 'o',     '<C-w>o', { exit = true, desc = 'remain only' } },
    { '<C-o>', '<C-w>o', { exit = true, desc = false } },

		-- equalize window sizes
		{ "e", "<C-w>=" },

		-- close active window
		{ "Q", ":q<cr>" },
		{ "<C-q>", ":q<cr>" },

		-- exit this Hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ ";", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true, nowait = true } },
	},
})
local gitsigns = require('gitsigns')

local githint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^                                                         _q_: exit
]]
Hydra({
   name = 'Git',
   hint = githint,
   config = {
      buffer = bufnr,
      color = 'pink',
      invoke_on_body = true,
      hint = {
         border = 'rounded'
      },
      on_enter = function()
         vim.cmd 'mkview'
         vim.cmd 'silent! %foldopen!'
         vim.bo.modifiable = false
         gitsigns.toggle_signs(true)
         gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
         local cursor_pos = vim.api.nvim_win_get_cursor(0)
         vim.cmd 'loadview'
         vim.api.nvim_win_set_cursor(0, cursor_pos)
         vim.cmd 'normal zv'
         gitsigns.toggle_signs(false)
         gitsigns.toggle_linehl(false)
         gitsigns.toggle_deleted(false)
      end,
   },
   mode = {'n','x'},
   body = '<leader>g',
   heads = {
      { 'J',
         function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'next hunk' } },
      { 'K',
         function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
         end,
         { expr = true, desc = 'prev hunk' } },
      { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
      { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
      { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
      { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
      { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
      { 'b', gitsigns.blame_line, { desc = 'blame' } },
      { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
      { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
      { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
   }
})
