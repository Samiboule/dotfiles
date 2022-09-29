local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'kevinhwang91/nvim-hlslens'
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use 'lewis6991/impatient.nvim'
  use 'junegunn/fzf.vim'
  use 'nathom/filetype.nvim'
  use 'jreybert/vimagit'
  use 'lewis6991/gitsigns.nvim'
  use 'lervag/vimtex'
  use "EdenEast/nightfox.nvim"
  use 'norcalli/nvim-colorizer.lua'
  use 'nvim-lualine/lualine.nvim'
  use 'simnalamburt/vim-mundo'
  use 'simeji/winresizer'
  use 'petertriho/nvim-scrollbar'
  use 'moll/vim-bbye'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'neovim/nvim-lspconfig'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
