-- 基础编辑配置
local options = {
  -- 2 空格作为 tab
  tabstop = 2,
	expandtab = true,
	shiftwidth = 2,

  clipboard = "unnamedplus", -- 系统剪贴板
  fileencoding = "utf-8",
  hlsearch = true, -- 搜索高亮
  ignorecase = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,

  mouse = "a", -- 启用鼠标
  showmode = false, -- 不展示当前编辑状态
  showtabline = 2, -- 展示标签栏
  updatetime = 300, -- 提升自动补全速度
  number = true, -- 行号
  relativenumber = true, -- 使用相对行号
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false, -- 不换行
  guifont = "JetBrainsMono Nerd Font"
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

