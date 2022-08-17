local telescope = require('telescope')

local command_center = require("command_center")
local noremap = {noremap = true}
local silent_noremap = {noremap = true, silent = true}

function add_command(desc, cmd)
  command_center.add({{
    desc = desc,
    cmd = cmd,
  }})
end

local commands = {
  {"Git: show commits", ":Telescope git_commits<cr>"},
  {"Git: show branches", ":Telescope git_branches<cr>"},
  {"Git: show git file status", ":Telescope git_status<cr>"},
  {"CMake: configure", ":CMake<cr>"},
  {"CMake: build target", ":CMakeBuild<cr>"},
  {"CMake: run target", ":CMakeRun<cr>"},
  {"CMake: select target", ":Telescope cmake4vim select_target<cr>"},
  {"CMake: select cmake kit", ":Telescope cmake4vim select_kit<cr>"},
  {"CMake: select build type", ":Telescope cmake4vim select_build_type<cr>"},
  {"CMake: clean cache", ":CMakeClean<cr>"},
  {"CMake: cmake info", ":CMakeInfo<cr>"},
  {"Markdown: preview markdown", ":Glow<cr>"},
}

for _, cmd in pairs(commands) do
  add_command(cmd[1], cmd[2])
end

telescope.load_extension('command_center')
