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

  use "nvim-treesitter/nvim-treesitter-context"

  use "kyazdani42/nvim-tree.lua"
  use "nvim-telescope/telescope.nvim"
  use {
    "FeiyouG/command_center.nvim",
    requires = { "nvim-telescope/telescope.nvim" }
  }
  use { 'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim' }
  use {
    'EthanJWright/vs-tasks.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim'
    }
  }

  -- ui
  use "p00f/nvim-ts-rainbow"
  use 'hoob3rt/lualine.nvim'
  use "kyazdani42/nvim-web-devicons"
  use 'kdheepak/tabline.nvim'
  use 'stevearc/dressing.nvim' -- 增强 vim.select 能力
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  -- 命令行
  use { "akinsho/toggleterm.nvim", tag = 'v2.*' }

  -- 高亮使用行
  use 'edluffy/specs.nvim'

  -- 主题
  use 'shaunsingh/nord.nvim'
  use 'folke/tokyonight.nvim'
  use 'rmehri01/onenord.nvim'

  -- 补全
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'fannheyward/telescope-coc.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq' }
  use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  -- 格式化
  use 'williamboman/mason.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  use "folke/which-key.nvim"


  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  -- Markdown Preview
  use { "ellisonleao/glow.nvim" }

  -- Dashboard
  use {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
  }

  -- CMake
  -- use 'ilyachur/cmake4vim'
  -- use 'SantinoKeupp/telescope-cmake4vim.nvim'
  -- use 'SantinoKeupp/lualine-cmake4vim.nvim'
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

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
