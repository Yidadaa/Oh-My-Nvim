require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

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
    name = "命令行窗口",
    t = { ":ToggleTerm direction=float<cr>a<bs>", "打开命令行" },
    s = { ":ToggleTermSendVisualSelection<cr>a<bs>", "在命令行中执行选中的文本" },
    v = { ":ToggleTerm direction=vertical<cr>a<bs>", "垂直分割打开命令行" },
    h = { ":ToggleTerm direction=horizontal<cr>a<bs>", "水平分割打开命令行" },
    b = { ":ToggleTerm direction=tab<cr>a<bs>", "新 tab 中打开命令行" },
    f = { ":ToggleTerm direction=float<cr>a<bs>", "浮动窗口中打开命令行" },
    k = { function() require("telescope").extensions.vstask.tasks() end, "执行任务" };
  }
}, {
  prefix = "<leader>"
})

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
  }
}, {
  prefix = ""
})

wk.register({
  f = {
    name = "格式化操作",
    f = { "<Plug>(coc-format-selected)", "格式化选中区域" },
  }
}, {
  prefix = "<leader>",
  mode = "x"
})
