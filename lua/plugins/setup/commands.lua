local telescope = require('telescope')

local command_center = require("command_center")
local noremap = { noremap = true }
local silent_noremap = { noremap = true, silent = true }

function add_command(desc, cmd)
  command_center.add({ {
    desc = desc,
    cmd = cmd,
  } })
end

local commands = {
  { "Git: 查看 commits", ":Telescope git_commits<cr>" },
  { "Git: 查看 branches", ":Telescope git_branches<cr>" },
  { "Git: 查看 git 文件状态（git status）", ":Telescope git_status<cr>" },
  { "Git: 查看文件变更 split view", ":DiffviewOpen<cr>" },
  { "Git: 刷新文件变更 split view", ":DiffviewRefresh<cr>" },
  { "Git: 查看当前文件历史记录", ":DiffviewFileHistory<cr>" },
  { "CMake: configure", ":CMake<cr>" },
  { "CMake: build target", ":CMake build<cr>" },
  { "CMake: run target", ":CMake run<cr>" },
  { "CMake: debug target", ":CMake debug<cr>" },
  { "CMake: build and debug target", ":CMake build_and_debug<cr>" },
  { "CMake: select target", ":CMake select_target<cr>" },
  { "CMake: select cmake kit", ":CMake select_kit<cr>" },
  { "CMake: select build type", ":CMake select_build_type<cr>" },
  { "CMake: clean cache", ":CMake clear_cache<cr>" },
  { "CMake: cmake create project", ":CMake create_project<cr>" },
  { "CMake: cmake cancel", ":CMake cancel<cr>" },
  { "Markdown: preview markdown", ":Glow<cr>" },
  { "Jest: 运行当前测试文件", ":JestRun<cr>" },
}

for _, cmd in pairs(commands) do
  add_command(cmd[1], cmd[2])
end

telescope.load_extension('command_center')
