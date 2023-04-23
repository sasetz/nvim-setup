-- set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- lsp configuration
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- lsp manager
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- spinner and status for lsp
      'j-hui/fidget.nvim',

      -- additional lua configuration and docs
      'folke/neodev.nvim',
    },
  }

  -- autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
  }

  -- highlighting, navigation, syntax overall
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  -- additional text objects for treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- git command inside neovim
  use 'tpope/vim-fugitive'
  -- github command to browse it
  use 'tpope/vim-rhubarb'
  -- inspect git data (blame, add, etc.) per line
  use 'lewis6991/gitsigns.nvim'

  -- Catpuccin theme
  use { 'catppuccin/nvim', as = 'catppuccin' }

  -- status line
  use 'nvim-lualine/lualine.nvim'

  -- indent even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- automatically add pair brackets
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  -- comments action
  use 'numToStr/Comment.nvim'
  -- autodetect tab width
  use 'tpope/vim-sleuth'

  -- file browser
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- welcome screen on startup
  -- TODO: make so that the open directory behaves as normal
  -- TODO: make so that it works with autosession
  use {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- list of errors and lsp messages, as well as todos
  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('trouble').setup {
        position = 'right',
        width = 45,
        action_keys = {
          close = { 'q', '<esc>' }
        }
      }
    end
  }

  -- add todos and such special comments to the diagnostics list on the right
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {
      }
    end
  }

  -- key mappings hints, press leader (space) and wait for a second to show
  use {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup {
      }
    end
  }

  -- cheatsheet to make notes about new features I add
  use {
    'sudormrfbin/cheatsheet.nvim',

    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- add color tint to bg of the hex colors for CSS
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require("colorizer").setup(nil, { css = true }) end,
  }

  -- reformat lines so that they align by some char
  use { 'godlygeek/tabular' }

  -- add sessions, restores layout for each project
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  }

  -- work with projects rather than folders
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }

  -- plugin for displaying layout
  use {
    'stevearc/aerial.nvim',
  }

  -- C/CPP lsp
  use {
    'ranjithshegde/ccls.nvim'
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- bootstrapping message
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- load the configurations
require('plugins.plugins')
