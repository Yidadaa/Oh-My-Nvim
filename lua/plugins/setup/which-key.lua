require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

local wk = require("which-key")

wk.register({
  f = {
    name = "文件操作",
    s = {":Telescope live_grep<CR>", "搜索所有文件"},
    g = {":Telescope git_files<CR>", "搜索 git 索引的文件"},
    w = {":Telescope grep_string<CR>", "搜索当前单词"},
    f = {":Telescope buffers<CR>", "搜索 buffer"},
    o = { "<Plug>(coc-format-selected)", "格式化选中区域" },
  },
  a = {
    name = "代码操作",
    c = { "<Plug>(coc-codeaction)", "显示所有代码操作" },
    f = { "<Plug>(coc-fix-current)", "AutoFix 当前行" }
  },
  r = {
    name = "重命名操作",
    n = { "<Plug>(coc-rename)", "重命名当前变量" }
  }
}, {
  prefix = "<leader>"
})

wk.register({
  g = {
    name = "Coc 操作",
    d = { "<Plug>(coc-definition)", "跳转到函数定义"},
    t = { "<Plug>(coc-type-definition)", "跳转到类型定义" },
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
