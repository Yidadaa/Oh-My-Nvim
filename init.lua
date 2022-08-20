local modules = {
  "keymaps",
  "plugins.install",
  "plugins.setup.all",
  "options",
}

-- 自动重载
for _, v in pairs(modules) do
  package.loaded[v] = nil
  require(v)
end
