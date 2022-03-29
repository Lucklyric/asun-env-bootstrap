local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  -- use "moll/vim-bbye"
  use "Asheq/close-buffers.vim"
  use "nvim-lualine/lualine.nvim"
  use "voldikss/vim-floaterm"
  -- use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "easymotion/vim-easymotion" -- Easymotion
  use { 'kkoomen/vim-doge', run = function() vim.fn['doge#install']() end }
  -- use "axelf4/vim-strip-trailing-whitespace"

  -- better buffer delete management
  -- use 'Asheq/close-buffers.vim'

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "lunarvim/darkplus.nvim"
  use "lucklyric/palenight.vim"
  use "sheerun/vim-polyglot"


  -- Markdown
  use "lervag/vimtex"
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
  use {'lucklyric/markdown-preview.nvim', run = 'cd app && yarn install'}
  use "plasticboy/vim-markdown"
  use 'mzlogin/vim-markdown-toc'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  -- use "L3MON4D3/LuaSnip" --snippet engine
  -- use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'honza/vim-snippets'
  -- use 'SirVer/ultisnips'
  -- use 'quangnguyen30192/cmp-nvim-ultisnips'
  use {'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile'}


  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "github/copilot.vim"
  -- use "Lucklyric/copilot.vim"
  use {"neoclide/coc.nvim", branch = "release"}

  -- lint
  use "wfleming/vim-codeclimate"

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Test
  use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }


  -- Git
  -- use "lewis6991/gitsigns.nvim"

  -- Smart Contract
  use "tomlion/vim-solidity"
  use "Cian911/vim-cadence"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
