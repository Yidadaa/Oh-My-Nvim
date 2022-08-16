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
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-context"

  use "kyazdani42/nvim-tree.lua"
  use "nvim-telescope/telescope.nvim"
  use "p00f/nvim-ts-rainbow"
  use 'hoob3rt/lualine.nvim'
  use "kyazdani42/nvim-web-devicons"
  use 'kdheepak/tabline.nvim'

  use {"akinsho/toggleterm.nvim", tag = 'v2.*'}
  use 'edluffy/specs.nvim'

  use 'shaunsingh/nord.nvim'
  use 'folke/tokyonight.nvim'
  use 'rmehri01/onenord.nvim'
  use "williamboman/mason.nvim"

  -- use 'neoclide/coc.nvim'
  use({"neovim/nvim-lspconfig"})
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use "glepnir/lspsaga.nvim"

  use {'ms-jpq/coq_nvim', branch = 'coq'}
  use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  use {'ms-jpq/coq.thirdparty', branch = '3p'}

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
