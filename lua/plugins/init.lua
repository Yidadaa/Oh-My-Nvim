-- Lazy.nvim installation
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

vim.g.mapleader = " "

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup({
  -- 启动加速
  { 'lewis6991/impatient.nvim', lazy = false },

  -- Lua 开发
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "christianchiarulli/lua-dev.nvim",

  -- 补全
  "christianchiarulli/nvim-cmp",
  "hrsh7th/cmp-cmdline", -- 补全底部命令行
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  -- 格式化
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jay-babu/mason-null-ls.nvim",
  "neovim/nvim-lspconfig",
  'mhartington/formatter.nvim',
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- 错误提示
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  },

  -- 高亮
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  },
  "nvim-treesitter/nvim-treesitter-context",

  -- 侧边栏
  "kyazdani42/nvim-tree.lua",

  -- 搜索
  { "nvim-telescope/telescope.nvim" },

  -- 命令中心
  {
    "FeiyouG/command_center.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
  { 'axkirillov/easypick.nvim', dependencies = 'nvim-telescope/telescope.nvim' },


  -- 括号
  "p00f/nvim-ts-rainbow",
  -- 底栏
  'hoob3rt/lualine.nvim',
  -- icon
  'nvim-tree/nvim-web-devicons',
  -- tab 栏
  'kdheepak/tabline.nvim',
  -- 弹出框 ui，增强 vim.select 能力
  'stevearc/dressing.nvim',
  -- 缩进栏
  "lukas-reineke/indent-blankline.nvim",
  -- 猜测缩进
  {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  },
  -- 错误展示
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  },

  -- 命令行
  { "akinsho/toggleterm.nvim", version = 'v2.*' },

  -- 主题
  'folke/tokyonight.nvim',


  -- 符号树
  { "simrat39/symbols-outline.nvim", config = function()
    require("symbols-outline").setup()
  end },

  -- 快捷键指引
  "folke/which-key.nvim",

  -- 快速跳转
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },

  -- Markdown Preview
  { "ellisonleao/glow.nvim" },

  -- CMake
  'Shatur/neovim-cmake',

  -- Debug 相关
  'mfussenegger/nvim-dap',
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  'nvim-telescope/telescope-dap.nvim',
  'theHamsta/nvim-dap-virtual-text',

  -- 注释
  'JoosepAlviste/nvim-ts-context-commentstring',
  { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end },

  -- doxygen 风格注释
  { "danymat/neogen", config = function() require('neogen').setup {} end,
    dependencies = "nvim-treesitter/nvim-treesitter" },

  -- 零延迟 escape
  { "max397574/better-escape.nvim", config = function() require("better_escape").setup() end },

  -- 多行编辑
  'mg979/vim-visual-multi',

  -- 搜索
  { 'VonHeikemen/searchbox.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },

  -- git
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  { 'akinsho/git-conflict.nvim', config = function() require('git-conflict').setup() end },
  'f-person/git-blame.nvim',
  { 'lewis6991/gitsigns.nvim', version = 'release', config = function()
    require('gitsigns').setup()
  end },

  -- 项目管理
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = {
          ".git", ".vscode", "Makefile"
        }
      }
    end
  },

  -- buffer 操作
  'famiu/bufdelete.nvim',
})
