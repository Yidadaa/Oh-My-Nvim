local modules = {
  "plugins.install",
  "plugins.setup.all",
  "options",
  "keymaps",
  "test",
  "cmd",
}

pcall(require, 'impatient')

-- 自动重载
function init()
  for _, v in pairs(modules) do
    package.loaded[v] = nil
    require(v)
  end
end

init()
