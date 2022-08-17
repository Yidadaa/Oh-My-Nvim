local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

---@diagnostic disable-next-line: missing-parameter
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
    autocmd BufWritePost init.lua source <afile> | PackerSync
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

  use "p00f/nvim-ts-rainbow"
  use 'hoob3rt/lualine.nvim'
  use "kyazdani42/nvim-web-devicons"
  use 'kdheepak/tabline.nvim'

  use {"akinsho/toggleterm.nvim", tag = 'v2.*'}
  use 'edluffy/specs.nvim'

  use 'shaunsingh/nord.nvim'
  use 'folke/tokyonight.nvim'
  use 'rmehri01/onenord.nvim'
  -- use "williamboman/mason.nvim"

  use {'neoclide/coc.nvim', branch = 'release'}
  use 'fannheyward/telescope-coc.nvim'

  use 'williamboman/mason.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  use {'ms-jpq/coq_nvim', branch = 'coq'}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'}

  use "folke/which-key.nvim"
  
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use {"ellisonleao/glow.nvim"}

  use {
      'goolord/alpha-nvim',
      config = function ()
          require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
  }

  use 'ilyachur/cmake4vim'
  use 'SantinoKeupp/telescope-cmake4vim.nvim'

  -- Debug 相关
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
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

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
