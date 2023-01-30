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

local total = 0
function load()
  for _, v in pairs(configs) do
    local st = vim.loop.hrtime()
    require(v)
    st = vim.loop.hrtime() - st
    total = total + st
    -- print(string.format("Loading %s at %s", v, st / 1000000))
  end

  vim.defer_fn(function()
    vim.notify(string.format("启动耗时: %s ms", total / 1000000))
  end, 500)
end

load()
