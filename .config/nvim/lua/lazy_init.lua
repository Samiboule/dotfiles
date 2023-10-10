local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'numToStr/Comment.nvim',
    config = function()
      require("Comment").setup()
    end,
  },
  'lewis6991/impatient.nvim',
  'tpope/vim-characterize',
  'ibhagwan/fzf-lua',
  'nathom/filetype.nvim',
  'lewis6991/gitsigns.nvim',
  'lervag/vimtex',
  'EdenEast/nightfox.nvim',
  'nyngwang/nvimgelion',
  'daschw/leaf.nvim',
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  'norcalli/nvim-colorizer.lua',
  'xiyaowong/nvim-cursorword',
  {
    'jinh0/eyeliner.nvim',
    enabled = true,
  },
  "lukas-reineke/indent-blankline.nvim",
  'nvim-lualine/lualine.nvim',
  'mbbill/undotree',
  'anuvyklack/hydra.nvim',
  'jbyuki/venn.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/playground',
    build = ':TSInstall query',
  },
  'nvim-treesitter/nvim-treesitter-context',
  'neovim/nvim-lspconfig',
  {
    'mrcjkb/haskell-tools.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    branch = '1.x.x',
    enabled = false,
  },
  'akinsho/toggleterm.nvim',
  {
    'j-hui/fidget.nvim',
    enabled = false,
  },
  'h-hg/fcitx.nvim',
  'suxpert/vimcaps',
  'windwp/nvim-autopairs',
  {
    'Wansmer/treesj',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      local tsj_utils = require('treesj.langs.utils')
      require('treesj').setup({
        use_default_keymaps = false,
        langs = {
          scheme = {
            ['list'] = tsj_utils.set_preset_for_list(),
          },
        },
      })
    end
  },
  'folke/neodev.nvim',
  'L3MON4D3/LuaSnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',

  --[[ 'mfussenegger/nvim-dap'
  'rcarriga/nvim-dap-ui'
  'theHamsta/nvim-dap-virtual-text' ]]
})
