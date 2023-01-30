require("mason").setup()

require("mason-lspconfig").setup {
  ensure_installed = {
    "clangd", "eslint", "jsonls", "tsserver", "remark_ls",
    "pyright", "rust_analyzer", "volar",
    "sumneko_lua", "bashls"
  }
}

local lsp = require("lspconfig")

-- 使用圆角窗口
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
  border = _border
}
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
  border = _border
}
)

vim.diagnostic.config {
  float = { border = _border }
}

require('lspconfig.ui.windows').default_options = {
  border = _border
}

-- 格式化
local null_ls = require("null-ls")

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
  },
  border = 'rounded'
}

lsp.clangd.setup {}
lsp.eslint.setup {}
lsp.jsonls.setup {}
lsp.tsserver.setup {}
lsp.remark_ls.setup {}
lsp.pyright.setup {}
lsp.rust_analyzer.setup {}
lsp.volar.setup {}
lsp.sumneko_lua.setup {}
lsp.bashls.setup {}
lsp.cmake.setup {}

lsp.util.default_config.capabilities = vim.tbl_deep_extend(
  'force',
  lsp.util.default_config.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)
