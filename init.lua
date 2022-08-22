local modules = {
  "plugins.install",
  "plugins.setup.all",
  "options",
  "keymaps",
}

-- 自动重载
for _, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
