-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true, -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false, -- Non focused panes set to alternative background
    styles = { -- Style to be applied to different syntax groups
      comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = { -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"

require("catppuccin").setup({
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = true,
	term_colors = true,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		cmp = true,
		gitsigns = true,
    treesitter_context = true,
		treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
	color_overrides = {},
  custom_highlights = {
      Comment = { fg = colors.overlay1 },
      LineNr = { fg = colors.overlay1 },
      TreesitterContextLineNumber = { fg = colors.overlay1 },
      debugBreakPoint = { fg = '#AA0000' },
      CursorLine = { bg = colors.none },
      CursorLineNr = { fg = colors.lavender },
      DiagnosticVirtualTextError = { bg = colors.none },
      DiagnosticVirtualTextWarn = { bg = colors.none },
      DiagnosticVirtualTextInfo = { bg = colors.none },
      DiagnosticVirtualTextHint = { bg = colors.none },
      VertSplit = { fg = '#6c7086' },
    },
})


require("leaf").setup({
    underlineStyle = "undercurl",
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    variablebuiltinStyle = "italic",
    transparent = true,
    colors = {},
    overrides = {},
    theme = "auto", -- default, based on vim.o.background, alternatives: "light", "dark"
    contrast = "high", -- default, alternatives: "medium", "high"
})

vim.cmd([[
let g:catppuccin_flavour = "mocha"

colorscheme catppuccin
]])

-- vim.cmd([[
--   colorscheme nightfox
-- ]])

-- vim.cmd([[
-- colorscheme nvimgelion
-- transparent bg
-- hi Normal guibg=NONE ctermbg=NONE
-- hi clear LineNr
-- hi IndentBlanklineChar gui=nocombine guifg=#444C55
-- hi IndentBlanklineSpaceChar gui=nocombine guifg=#4d5154
-- " NOTE: don't use `gui=nocombine` here to have correct coloring of gitsigns.nvim.
-- hi IndentBlanklineContextStart gui=underline guisp=#FB5E2A
-- ]])

-- vim.cmd("colorscheme leaf")
