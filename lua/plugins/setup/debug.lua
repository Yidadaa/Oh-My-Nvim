require("dapui").setup {
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.6 },
        { id = "breakpoints", size = 0.1 },
        { id = "stacks", size = 0.3 },
      },
      size = 40,
      position = 'right'
    },
    {
      elements = {
        "repl"
      },
      size = 0.25,
      position = 'bottom'
    }
  }
}

require('telescope').load_extension('dap')
require("nvim-dap-virtual-text").setup()

local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/local/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.defaults.fallback.exception_breakpoints = { 'uncaught', 'raised' }

local dapui = require('dapui')
dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.notify("Launching DAP UI, please wait...", nil, { title = "DAP" })
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
