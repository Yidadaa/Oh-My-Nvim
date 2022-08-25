local modules = {
  "plugins.install",
  "plugins.setup.all",
  "options",
  "keymaps",
}

-- 自动重载
function init()
  for _, v in pairs(modules) do
    local st = vim.loop.hrtime()
    package.loaded[v] = nil
    require(v)
    st = vim.loop.hrtime() - st
    -- print(string.format("Loading %s at %s", v, st))
  end
end

init()
