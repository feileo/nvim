return {
  "nvim-lua/plenary.nvim",

  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
    event = "VimEnter",
  },

  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
    event = "VimEnter",
  },

  "nvzone/volt",
  "nvzone/menu",
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },

  -- disable default plugin which-key
  {
    "folke/which-key.nvim",
    enabled = false,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      return require "configs.blankline"
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "yamatsum/nvim-cursorline",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-cursorline").setup(require "configs.cursorline")
    end,
  },

  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      return require "configs.dashboard"
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    -- ft = { "gitcommit", "diff" },
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  -- Claude Code AI 助手
  -- {
  --   "coder/claudecode.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "folke/snacks.nvim" },
  --   opts = function()
  --     return require "configs.claudecode"
  --   end,
  --   keys = {
  --     { "<leader>cc", desc = "AI/Claude Code" },
  --     { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
  --     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
  --     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
  --     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
  --     { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
  --     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
  --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v", desc = "Send to Claude" },
  --     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
  --     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
  --   },
  -- },

  {
    "mason-org/mason.nvim",
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      return require "configs.treesitter"
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function()
      return require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    version = "v1.2.0", -- 锁定版本，避免弃用警告
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = function()
      return require "configs.lspsaga"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "leisiji/interestingwords.nvim",
    cmd = "Interestingwords",
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = function()
      return require "configs.supermaven"
    end,
  },

  -- 覆盖 nvim - cmp 配置以与 supermaven 协作
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "configs.cmp"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "potamides/pantran.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.pantran"
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      local noice_config = require "configs.noice"
      require("noice").setup(noice_config.config)
      noice_config.setup_highlights()
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    opts = function()
      return require "configs.telescope"
    end,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- {
  --     "ray-x/go.nvim",
  --     dependencies = {  -- optional packages
  --       "ray-x/guihua.lua",
  --       "neovim/nvim-lspconfig",
  --       "nvim-treesitter/nvim-treesitter",
  --     },
  --     config = function()
  --         require("go").setup()
  --     end,
  --     event = {"CmdlineEnter"},
  --     ft = {"go", 'gomod'},
  --     build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  -- },

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    opts = function()
      return require "configs.gopher"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
    },
  },
}
