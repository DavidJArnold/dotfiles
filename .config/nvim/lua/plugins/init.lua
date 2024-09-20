return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        branch = "legacy",
      },

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',

  'navarasu/onedark.nvim',                                          -- Theme inspired by Atom
  'nvim-lualine/lualine.nvim',                                      -- Fancier statusline
  { 'lukas-reineke/indent-blankline.nvim',      main = 'ibl',     opts = {} }, -- Add indentation guides even on blank lines
  'numToStr/Comment.nvim',                                          -- "gc" to comment visual regions/lines
  'tpope/vim-sleuth',                                               -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',            branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',   cond = vim.fn.executable 'make' == 1 },

  { 'HallerPatrick/py_lsp.nvim' },

  -- Glow for markdown preview
  { "ellisonleao/glow.nvim",                    config = true,    cmd = "Glow" },

  -- which key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- {
  --  "m4xshen/hardtime.nvim",
  --  dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" },
  --  opts = {}
  -- },

  -- codesnap for screenshots
  {
    "DavidJArnold/codesnap.nvim", build = "make", opts = { save_path = "~/codesnaps" }
  },

  -- -- copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },
  --
  -- -- copilot cmp
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup({})
  --   end,
  -- },
  --
  -- -- copilot chat
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "canary",
  --   dpendencies = {
  --     {"nvim-lua/plenary.nvim" },
  --     { "zbirenbaum/copilot.lua" },
  --   },
  --   build = "make tiktoken",
  --   opts = {
  --     debug = true,
  --   },
  -- },
}
