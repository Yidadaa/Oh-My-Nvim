local wk = require("which-key")

wk.register({
  f = {
    name = "文件操作",
    s = { ":Telescope live_grep<CR>", "搜索所有文件" },
    g = { ":Telescope git_files<CR>", "搜索 git 索引的文件" },
    w = { ":Telescope grep_string<CR>", "搜索当前单词" },
    f = { ":Telescope buffers<CR>", "搜索 buffer" },
    o = { "<Plug>(coc-format-selected)", "格式化选中区域" },
  },
  s = {
    name = "搜索替换",
    s = { ":Telescope live_grep<CR>", "搜索所有文件" },
    r = { ":SearchBoxReplace<cr>", "搜索当前文件并替换" },
  },
  a = {
    name = "代码操作",
    c = { "<Plug>(coc-codeaction)", "显示所有代码操作" },
    f = { "<Plug>(coc-fix-current)", "AutoFix 当前行" }
  },
  r = {
    name = "重命名操作",
    n = { "<Plug>(coc-rename)", "重命名当前变量" },
    r = { ":SearchBoxReplace<cr>", "搜索当前文件并替换" },
  },
  l = {
    name = "Coc List 操作",
    d = { ":CocList diagnostics<cr>", "跳转诊断信息" },
    e = { ":CocList extensions<cr>", "跳转 coc extensions" },
    c = { ":CocList commands<cr>", "跳转 coc commands" },
    o = { ":CocList outline<cr>", "跳转 coc outline" },
    s = { ":CocList -I symbols<cr>", "跳转 coc symbols" },
    p = { ":CocListResume<cr>", "恢复上一次 coc list" },
    r = { ":Telescope coc references<cr>", "查找所有引用" },
  },
  t = {
    name = "命令行和文件树",
    t = { ":NvimTreeToggle<cr>", "切换文件树" },
    s = { ":ToggleTermSendVisualSelection<cr>a<bs>", "在命令行中执行选中的文本" },
    v = { ":ToggleTerm direction=vertical<cr>a<bs>", "垂直分割打开命令行" },
    h = { ":ToggleTerm direction=horizontal<cr>a<bs>", "水平分割打开命令行" },
    b = { ":ToggleTerm direction=tab<cr>a<bs>", "新 tab 中打开命令行" },
    f = { ":ToggleTerm direction=float<cr>a<bs>", "浮动窗口中打开命令行" },
    k = { function() require("telescope").extensions.vstask.tasks() end, "执行任务" };
  },
  g = {
    name = "Git 操作",
    g = { ":TermExec cmd=gitui<cr>", "调用 gitui" },
    o = { ":GitConflictChooseOurs<cr>", "Git 使用我们的更改" },
    t = { ":GitConflictChooseTheirs<cr>", "Git 使用他们的更改" },
    b = { ":GitConflictChooseBoth<cr>", "Git 两个全都要" },
    n = { ":GitConflictChooseNone<cr>", "Git 全都不要" },
    j = { ":GitConflictNextConflict<cr>", "Git 下一个冲突" },
    k = { ":GitConflictPrevConflict<cr>", "Git 上一个冲突" },
    l = { ":GitConflictListQf<cr>", "Git 所有冲突 quickfix" },
    s = { ":Telescope git_status<cr>", "Git 查看改动文件状态" },
    c = { ":Telescope git_commits<cr>", "Git 查看 commit" },
    h = { ":DiffviewFileHistory<cr>", "Git 查看当前文件历史记录" }
  },
  d = {
    name = "调试",
    b = { ":CMake build_and_debug<cr>", "构建并调试当前 target" },
    s = { ":CMake select_target<cr>", "切换 CMake target" }
  },
  b = {
    name = "断点",
    b = { ":DapToggleBreakpoint<cr>", "切换断点" },
    r = { ":DapToggleRepl<cr>", "切换调试窗口" },
    i = { ":DapStepInto<cr>", "调试跳入" },
    o = { ":DapStepOut<cr>", "调试跳出" },
    n = { ":DapStepOver<cr>", "调试步进" },
    x = { ":DapTerminate<cr>", "调试终止" },
    t = { ":DapVirtualTextToggle<cr>", "调试文本切换显示" },
  }
}, {
  prefix = "<leader>"
});

wk.register({
  g = {
    name = "Coc 操作",
    d = { "<Plug>(coc-definition)", "跳转到函数定义" },
    y = { "<Plug>(coc-type-definition)", "跳转到类型定义" },
    i = { "<Plug>(coc-implementation)", "跳转到实现" },
    r = { "<Plug>(coc-references)", "跳转到实现" },

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

wk.register({
  f = {
    name = "格式化操作",
    f = { "<Plug>(coc-format-selected)", "格式化选中区域" },
  }
}, {
  prefix = "<leader>",
  mode = "x"
});
