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
  augroup packer_ser_config
    autocmd!
    autocmd BufWritePost install.lua source <afile> | PackerSync
    autocmd BufWritePost treesitter.lua source <afile> | TSUpdate 
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

return packer.startup(function(use)
  -- Plugin Mangager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Lua 开发
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "nvim-lua/popup.nvim"
  use "christianchiarulli/lua-dev.nvim"

  -- 补全
  use "christianchiarulli/nvim-cmp"
  use "hrsh7th/cmp-cmdline" -- 补全底部命令行
  use "hrsh7th/cmp-buffer"
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- 高亮
  use "nvim-treesitter/nvim-treesitter-context"

  -- 侧边栏
  use "kyazdani42/nvim-tree.lua"

  -- 搜索
  use { "nvim-telescope/telescope.nvim" }

  -- 命令中心
  use {
    "FeiyouG/command_center.nvim",
    requires = { "nvim-telescope/telescope.nvim" }
  }
  use { 'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim' }


  -- 括号
  use "p00f/nvim-ts-rainbow"
  -- 底栏
  use 'hoob3rt/lualine.nvim'
  -- icon
  use 'nvim-tree/nvim-web-devicons'
  -- tab 栏
  use 'kdheepak/tabline.nvim'
  -- 弹出框 ui
  use 'stevearc/dressing.nvim' -- 增强 vim.select 能力
  -- 缩进栏
  use "lukas-reineke/indent-blankline.nvim"
  -- 猜测缩进
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }
  -- 错误展示
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  }

  -- 命令行
  use { "akinsho/toggleterm.nvim", tag = 'v2.*' }

  -- 主题
  use 'folke/tokyonight.nvim'

  -- 补全
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'fannheyward/telescope-coc.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  -- 格式化
  use 'williamboman/mason.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- 快捷键指引
  use "folke/which-key.nvim"

  -- 快速跳转
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  -- Markdown Preview
  use { "ellisonleao/glow.nvim" }

  -- CMake
  use 'Shatur/neovim-cmake'

  -- Debug 相关
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
  use 'nvim-telescope/telescope-dap.nvim'
  use 'theHamsta/nvim-dap-virtual-text'

  -- 注释
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- doxygen 风格注释
  use {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  }


  -- 多行编辑
  use 'mg979/vim-visual-multi'

  -- 搜索
  use {
    'VonHeikemen/searchbox.nvim',
    requires = {
      { 'MunifTanjim/nui.nvim' }
    }
  }

  -- git
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
    require('git-conflict').setup()
  end }

  -- 项目管理
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = {
          ".git", ".vscode", "README.md", "package.json"
        }
      }
    end
  }

  -- buffer 操作
  use 'famiu/bufdelete.nvim'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
