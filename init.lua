local modules = {
  "plugins.init",
  "plugins.setup.all",
  "options",
  "keymaps",
  "test",
  "cmd",
}

-- 自动重载
local total = 0
local function init()
  for _, v in pairs(modules) do
    local st = vim.loop.hrtime()
    package.loaded[v] = nil
    require(v)
    st = vim.loop.hrtime() - st
    total = total + st
  end

  vim.defer_fn(function()
    print(string.format("Start Time: %.5s ms", total / 1000000))
  end, 100)
end

init()
