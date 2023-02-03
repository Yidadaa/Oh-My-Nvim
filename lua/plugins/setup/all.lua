local configs = {
  'plugins.setup.nvim-tree',
  'plugins.setup.treesitter',
  'plugins.setup.telescope',
  'plugins.setup.fterm',
  'plugins.setup.tabline',
  'plugins.setup.theme',
  'plugins.setup.coc',
  'plugins.setup.cmp',
  'plugins.setup.which-key',
  'plugins.setup.commands',
  'plugins.setup.cmake',
  'plugins.setup.debug',
  'plugins.setup.git'
}

for _, v in pairs(configs) do
  require(v)
end
