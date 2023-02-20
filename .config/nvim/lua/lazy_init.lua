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
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  'norcalli/nvim-colorizer.lua',
  'jinh0/eyeliner.nvim',
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
  'nyngwang/murmur.lua',
  'neovim/nvim-lspconfig',
  'j-hui/fidget.nvim',
  'windwp/nvim-autopairs',
  'lewis6991/satellite.nvim',
  'folke/neodev.nvim',
  --[[ 'mfussenegger/nvim-dap'
  'rcarriga/nvim-dap-ui'
  'theHamsta/nvim-dap-virtual-text' ]]
  'L3MON4D3/LuaSnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',
})
