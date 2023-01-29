local wk = require("which-key")

local function toggle_quickfix()
  local qf_open = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_open = true
      break
    end
  end

  if qf_open then
    vim.cmd "cclose"
  else
    vim.cmd "copen"
  end
end

local function autofix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

wk.register({
  f = {
    name = "文件操作",
    s = { ":Telescope live_grep<CR>", "搜索文件内容" },
    g = { ":Telescope git_files<CR>", "搜索 git 索引的文件" },
    w = { ":Telescope grep_string<CR>", "搜索当前单词" },
    b = { ":Telescope buffers<CR>", "搜索 buffer" },
    f = { ":lua vim.lsp.buf.format{ async = true }<cr>", "格式化当前文件" },
  },
  s = {
    name = "搜索替换",
    r = { ":SearchBoxReplace<cr>", "搜索当前文件并替换" },
  },
  a = {
    name = "代码操作",
    f = { autofix, "当前行 Auto Fix" },
    c = { vim.lsp.buf.code_actions, "显示 Code Actions 操作" },
  },
  r = {
    name = "重命名操作",
    n = { vim.lsp.buf.rename, "重命名当前变量" },
    r = { ":SearchBoxReplace<cr>", "在当前文件中搜索并替换" },
  },
  l = {
    name = "调试和代码符号信息列表操作",
    d = { ":Telescope diagnostics<cr>", "跳转诊断信息" },
    s = { ":SymbolsOutline<cr>", "符号表大纲" },
    r = { ":Telescope lsp_references<cr>", "查找所有引用" },
    b = { ":Telescope dap list_breakpoints<cr>", "查看所有断点" },
    f = { ":Telescope dap frames<cr>", "查看调用栈" },
  },
  t = {
    name = "命令行和文件树",
    t = { ":NvimTreeToggle<cr>", "切换文件树" },
    s = { ":ToggleTermSendVisualSelection<cr>a<bs>", "在命令行中执行选中的文本" },
    v = { ":ToggleTerm direction=vertical<cr>a<bs>", "垂直分割打开命令行" },
    h = { ":ToggleTerm direction=horizontal<cr>a<bs>", "水平分割打开命令行" },
    b = { ":ToggleTerm direction=tab<cr>a<bs>", "新 tab 中打开命令行" },
    f = { ":ToggleTerm direction=float<cr>a<bs>", "浮动窗口中打开命令行" },
    x = { ":tabclose", "关闭标签页" },
  },
  g = {
    name = "Git 操作",
    g = { ":TermExec cmd=gitui<cr>", "使用 Git UI" },
    o = { ":GitConflictChooseOurs<cr>", "Git Conflict 使用我们的更改" },
    t = { ":GitConflictChooseTheirs<cr>", "Git Conflict 使用他们的更改" },
    b = { ":GitConflictChooseBoth<cr>", "Git Conflict 两个全都要" },
    n = { ":GitConflictChooseNone<cr>", "Git Conflict 全都不要" },
    j = { ":GitConflictNextConflict<cr>", "Git Conflict 下一个冲突" },
    k = { ":GitConflictPrevConflict<cr>", "Git Conflict 上一个冲突" },
    l = { ":GitConflictListQf<cr>", "Git Conflict quickfix 窗口" },
    s = { ":Telescope git_status<cr>", "Git 搜索改动文件" },
    c = { ":Telescope git_commits<cr>", "Git 查看 commit" },
    f = { ":DiffviewOpen<cr>", "Git 查看当前文件改动" },
    h = { ":DiffviewFileHistory %<cr>", "Git 查看当前文件历史记录" }
  },
  c = {
    name = "CMake 操作",
    c = { ":CMake<cr>", "CMake 配置" },
    b = { ":CMake build<cr>", "构建当前 target" },
    d = { ":CMake build_and_debug<cr>", "构建并调试当前 target" },
    r = { ":CMake build_and_run<cr>", "构建并运行当前 target" },
    s = { ":CMake select_target<cr>", "切换 CMake target" },
    x = { ":CMake cancel<cr>", "取消 CMake 任务" },
    a = { ":Catch2RunSingle<cr>", "运行单个 Catch2 Test Case" },
  },
  b = {
    name = "断点和 buffer",
    b = { ":DapToggleBreakpoint<cr>", "切换断点" },
    r = { ":DapToggleRepl<cr>", "切换 repl 窗口" },
    c = { ":DapContinue<cr>", "执行到下一个断点(continue)" },
    i = { ":DapStepInto<cr>", "调试跳入(step in)" },
    o = { ":DapStepOut<cr>", "调试跳出(step out)" },
    n = { ":DapStepOver<cr>", "调试步进(step over)" },
    x = { ":DapTerminate<cr>", "调试终止" },
    t = { ":DapVirtualTextToggle<cr>", "调试文本切换显示" },
    d = { ":lua require('bufdelete').bufdelete(0, true)<cr>", "关闭当前窗口" },
  },
  n = {
    name = "注释",
    g = { ":Neogen<cr>", "生成 doxygen 风格注释" }
  },
  q = {
    name = "quickfix 窗口",
    f = { toggle_quickfix, "切换 quickfix 窗口" },
    t = { ":tabnew<cr>:copen<cr>:only<cr>", "新 tab 中打开 quickfix 并全屏" },
  },
  j = {
    name = 'Jest 测试',
    r = { ":JestRun<cr>", "执行当前测试文件" },
    b = { ":JestRunBail<cr>", "执行测试 --bail" },
    c = { ":JestRunSingleCase<cr>", "执行光标处的用例" },
    w = { ":JestWatch<cr>", "监听当前测试文件" },
  }
}, {
  prefix = "<leader>"
});

wk.register({
  g = {
    name = "代码操作",
    h = { vim.lsp.buf.hover, "鼠标悬浮操作" },
    d = { vim.lsp.buf.definition, "跳转到函数定义" },
    t = { vim.lsp.buf.type_definition, "跳转到类型定义" },
    i = { vim.lsp.buf.implementations, "跳转到实现" },
    r = { vim.lsp.buf.references, "跳转到引用" },
    j = { vim.diagnostic.goto_next, "跳转到下一个问题" },
    k = { vim.diagnostic.goto_prev, "跳转到上一个问题" },

    l = { ":HopLine<cr>", "跳转到行" },
    w = { ":HopChar1<cr>", "跳转到字符" },
    p = { ":HopPattern<cr>", "跳转到模式" },
  },
  t = {
    name = "TabLine 操作",
    n = { ":TablineTabNew<cr>", "新建 tab" },
    j = { ":TablineBufferPrevious<cr>", "前一个 tab" },
    k = { ":TablineBufferNext<cr>", "后一个 tab" },
    h = { ":TablineBufferPrevious<cr>", "前一个 tab" },
    l = { ":TablineBufferNext<cr>", "后一个 tab" },
    t = { ":ToggleTerm direction=float<cr>a<bs>", "打开命令行" },
  }
}, {
  prefix = ""
});
