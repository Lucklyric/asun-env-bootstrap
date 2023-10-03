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


-- Install your plugins here
local plugins = {
  { "nvim-lua/popup.nvim" },   -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("user.telescope")
    end,
  },
  { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
  { "numToStr/Comment.nvim" }, -- Easily comment stuff
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-tree/nvim-tree.lua" },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("user.nvim-tree")
    end,
  },
  { "akinsho/bufferline.nvim" },
  { "Asheq/close-buffers.vim" },
  { "nvim-lualine/lualine.nvim" },
  { "voldikss/vim-floaterm" },
  { "ahmedkhalf/project.nvim" },
  --[[ {"lewis6991/impatient.nvim"}, ]]
  { "lukas-reineke/indent-blankline.nvim" },
  { "goolord/alpha-nvim" },
  --[[ { "antoinemadec/FixCursorHold.nvim" }, -- This is needed to fix lsp doc highlight ]]
  {
    "folke/which-key.nvim",
    config = function()
      require("user.whichkey")
    end
  },
  { "easymotion/vim-easymotion" }, -- Easymotion
  { 'kkoomen/vim-doge',         build = function() vim.fn['doge#install']() end },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("user.notify")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
  { "LunarVim/lunar.nvim" },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
        },
        on_highlights = function(hl, c)
          -- pink
          hl.String = { fg = "#ff9cac" }
        end
      })
    end
  },
  --[[ { "LunarVim/Colorschemes" }, ]]

  { "rafamadriz/neon" },

  -- Markdown
  { "lervag/vimtex" },
  { 'lucklyric/markdown-preview.nvim', build = 'cd app && yarn install' },
  { "plasticboy/vim-markdown" },
  { 'mzlogin/vim-markdown-toc' },

  -- cmp plugins
  { "hrsh7th/nvim-cmp" },         -- The completion plugin
  { "hrsh7th/cmp-buffer" },       -- buffer completions
  { "hrsh7th/cmp-path" },         -- path completions
  { "hrsh7th/cmp-cmdline" },      -- cmdline completions
  { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp" },

  -- aigc
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require('user.chatgpt')
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/which-key.nvim",
    }
  },
  --[[ { ]]
  --[[   "Bryley/neoai.nvim", ]]
  --[[   dependencies = { ]]
  --[[     "MunifTanjim/nui.nvim", ]]
  --[[   }, ]]
  --[[   cmd = { ]]
  --[[     "NeoAI", ]]
  --[[     "NeoAIOpen", ]]
  --[[     "NeoAIClose", ]]
  --[[     "NeoAIToggle", ]]
  --[[     "NeoAIContext", ]]
  --[[     "NeoAIContextOpen", ]]
  --[[     "NeoAIContextClose", ]]
  --[[     "NeoAIInject", ]]
  --[[     "NeoAIInjectCode", ]]
  --[[     "NeoAIInjectContext", ]]
  --[[     "NeoAIInjectContextCode", ]]
  --[[   }, ]]
  --[[   keys = { ]]
  --[[     { "<leader>as", desc = "summarize text" }, ]]
  --[[     { "<leader>ag", desc = "generate git message" }, ]]
  --[[   }, ]]
  --[[   config = function() ]]
  --[[     require("neoai").setup({ ]]
  --[[       -- Options go here ]]
  --[[     }) ]]
  --[[   end, ]]
  --[[ }, ]]
  --[[ { ]]
  --[[   "jackMort/ChatGPT.nvim", ]]
  --[[   event = "VeryLazy", ]]
  --[[   config = function() ]]
  --[[     require("chatgpt").setup({ ]]
  --[[       popup_input = { ]]
  --[[         submit = "<C-s>", ]]
  --[[       } ]]
  --[[     }) ]]
  --[[   end, ]]
  --[[   dependencies = { ]]
  --[[     "MunifTanjim/nui.nvim", ]]
  --[[     "nvim-lua/plenary.nvim", ]]
  --[[     "nvim-telescope/telescope.nvim" ]]
  --[[   } ]]
  --[[ }, ]]

  -- snippets
  { "L3MON4D3/LuaSnip" },             --snippet engine
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  -- use 'hrsh7th/cmp-vsnip'
  -- use 'hrsh7th/vim-vsnip'
  -- use 'honza/vim-snippets'
  -- use 'SirVer/ultisnips'
  -- use 'quangnguyen30192/cmp-nvim-ultisnips'
  -- use {'dsznajder/vscode-es7-javascript-react-snippets', run = 'yarn install --frozen-lockfile && yarn compile'}

  {
    'kevinhwang91/nvim-ufo',
    config = function() require('user.ufo') end,
    dependencies = {
      'kevinhwang91/promise-async' }
  },

  -- LSP
  { "williamboman/mason.nvim" },
  { "neovim/nvim-lspconfig" },        -- enable LSP
  { "williamboman/mason-lspconfig.nvim" },
  { "tamago324/nlsp-settings.nvim" }, -- language server settings defined in json for
  --[[ { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters ]]
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("user.lsp.null-ls")
    end,
  },
  { "ray-x/lsp_signature.nvim" },
  { "yamatsum/nvim-cursorline", config = function() require("user.cursorline") end },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  { "github/copilot.vim" },

  -- lint
  { "wfleming/vim-codeclimate" },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- indendt
  { "Darazaki/indent-o-matic",                    config = function() require("user.indent-o-matic") end },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
  },
  --[[ { 'nvim-treesitter/playground' }, ]]
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- Git
  { "lewis6991/gitsigns.nvim" },

  --- Java
  { 'mfussenegger/nvim-jdtls' },

  --- Rust
  { 'simrat39/rust-tools.nvim' },

  -- Smart Contract
  { "Cian911/vim-cadence" },
  { "modocache/move.vim" },

  --- Unity
  { "Lucklyric/omnisharp-extended-lsp.nvim" },

  --- minimap
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },

  --trouble
  {
    "folke/trouble.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- Lua
    },
    config = function()
      -- Lua
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
        { silent = true, noremap = true }
      )
    end
  }

};

local opts = {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false,                           -- should plugins be lazy-loaded?
    version = nil,
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  -- leave nil when passing the spec as the first argument to setup()
  spec = nil, ---@type LazySpec
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
  concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120,                  -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This is should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = true,
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/projects",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {},    -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "habamax" },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- open lazygit log
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,

      -- open a terminal for the plugin dir
      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "git",
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true,    -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {},          -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
}

require("lazy").setup(plugins, opts)
