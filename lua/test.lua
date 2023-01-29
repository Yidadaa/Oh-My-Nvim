local opts = { noremap = true, silent = true }

-- 基础键位设置
local keymap = vim.api.nvim_set_keymap

local function append_to_qf(s)
  vim.fn.setqflist({ { text = s } }, 'a')
end

local function clear_qf()
  vim.fn.setqflist({}, 'r')
end

-- 从文件中解析 case
local function parse_cases(tokens, token_regex)
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cursor_postion, _ = unpack(vim.api.nvim_win_get_cursor(0))

  local count = 0
  local cases = {}
  local sections = {}
  local max_indent = 0

  for index, line in ipairs(content) do
    for _, token in ipairs(tokens) do
      local test_name = string.match(line, token_regex(token))
      local indent = string.match(line, "(%s*)" .. token) -- 缩进
      if test_name then
        local indent_size = string.len(indent)
        count = count + 1
        table.insert(cases, { index, indent_size, test_name, token })
        if index <= cursor_postion then
          max_indent = indent_size
          sections[indent_size] = { index, indent_size, test_name, token }

          -- 删除所有比当前缩进更大的 section
          for _, section in pairs(sections) do
            local _, current_indent, _, _ = unpack(section)
            if current_indent > max_indent then
              sections[current_indent] = nil
            end
          end
        end
      end
    end
  end


  return max_indent, sections
end

local function wrap_with(content, surround)
  return surround .. content .. surround
end

local function test_command()
  clear_qf()

  local tokens = {}
  local token_names = {
    SCENARIO        = 'Scenario: ',
    SCENARIO_METHOD = 'Scenario: ',
    GIVEN           = '    Given: ',
    WHEN            = '     When: ',
    THEN            = '     Then: ',
    AND_GIVEN       = 'And given: ',
    AND_WHEN        = ' And when: ',
    AND_THEN        = ' And then: ',
  }

  for token, _ in pairs(token_names) do
    table.insert(tokens, token)
  end

  local token_regex = function(token)
    return token .. [[%("(.*)"]]
  end

  local _, sections = parse_cases(tokens, token_regex)

  -- 按缩进排序
  local indents = {}
  for _, case in pairs(sections) do
    local _, indent_level, _, _ = unpack(case)
    table.insert(indents, indent_level)
  end

  table.sort(indents)

  -- 生成 catch2 运行命令
  local catch2_section_param = {}
  local is_test_case = true
  for _, indent in pairs(indents) do
    local _, _, name, token = unpack(sections[indent])

    append_to_qf(token_names[token] .. name)

    local section_prefix = '-c '
    if is_test_case then
      section_prefix = ''
      is_test_case = false
    end

    table.insert(catch2_section_param, section_prefix .. wrap_with(token_names[token] .. name, [["]]))
  end

  local catch2_param = table.concat(catch2_section_param, ' ')
  catch2_param = catch2_param:gsub(' ', '\\ ')

  local ProjectConfig = require('cmake.project_config')
  local config = ProjectConfig.new()
  local target_dir, target, _ = config:get_current_target()

  if not target_dir or not target then
    return print('请在 CMake 项目中运行此命令')
  end

  local cmd_text = target.filename .. ' ' .. catch2_param
  append_to_qf(cmd_text)

  local cmd = "TermExec  direction=horizontal cmd=" .. wrap_with(cmd_text, [[']])
  append_to_qf(cmd)

  vim.cmd(cmd)
end

vim.api.nvim_create_user_command("Catch2RunSingle", test_command, {})

-- 在父路径中找到目标文件
local function find_path_in_parent(path, file_path)
  local target_file_path = ''
  local fmt_path = ''
  while target_file_path ~= '/' do
    fmt_path = fmt_path .. ':h'
    target_file_path = vim.fn.fnamemodify(path, fmt_path) .. '/' .. file_path
    if vim.fn.filereadable(target_file_path) == 1 then
      return target_file_path
    end
  end
  return ''
end

-- 判定字符串是否为指定后缀
local function has_suffix_ignore_case(str, suffix)
  str = string.lower(str)
  suffix = string.lower(suffix)
  return string.match(str, suffix .. "$") ~= nil
end

-- 获取鼠标处的测试用例名称
local function get_current_case_name()
  local tokens = { 'describe', 'test', 'it' }
  local token_regex = function(token)
    return token .. [[%('(.*)']]
  end

  local _, sections = parse_cases(tokens, token_regex)
  local section_names = {}
  for _, section in pairs(sections) do
    local _, _, name = unpack(section)
    table.insert(section_names, name)
  end

  local case_name = table.concat(section_names, ' ')

  return case_name
end

-- 上次文件后缀
local last_file_path = nil
local function jest_run(extra_params)
  local current_file_path = vim.fn.expand('%:p')

  -- 如果当前文件不是有效测试文件，则自动运行上次文件
  if string.find(current_file_path, '.test.ts') == nil then
    current_file_path = last_file_path
  else
    last_file_path = current_file_path
  end

  if current_file_path == nil then
    return vim.notify('请在 *.test.ts 中指定该命令！')
  end

  -- find jest.config.ts
  local jest_config_path = 'jest.config.ts'
  jest_config_path       = find_path_in_parent(current_file_path, jest_config_path)

  -- find jest bin
  local jest_bin_path = 'node_modules/jest/bin/jest.js'
  jest_bin_path       = find_path_in_parent(current_file_path, jest_bin_path)

  -- find tsconfig.json
  local ts_config_path = vim.fn.fnamemodify(find_path_in_parent(current_file_path, 'tsconfig.json'), ':h')

  local jest_cmd = table.concat({
    'node', jest_bin_path,
    current_file_path,
    '-c', jest_config_path,
    extra_params
  }, ' ')
  local cmd = [[TermExec cmd='cd ]] .. ts_config_path .. [[ && ]] .. jest_cmd .. [[']]
  vim.cmd(cmd)
end

local function run_jest_with(extra_params)
  return function()
    jest_run(extra_params)
  end
end

-- 执行光标处的 jest test case
local function jest_run_current_case()
  local case_name = get_current_case_name()

  vim.notify('执行测试：' .. case_name)
  jest_run('-t "' .. case_name .. '"')
end

vim.api.nvim_create_user_command("JestRun", run_jest_with(''), {})
vim.api.nvim_create_user_command("JestWatch", run_jest_with('--watch'), {})
vim.api.nvim_create_user_command("JestRunBail", run_jest_with('--bail'), {})
vim.api.nvim_create_user_command("JestRunSingleCase", jest_run_current_case, {})
