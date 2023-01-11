local opts = { noremap = true, silent = true }

-- 基础键位设置
local keymap = vim.api.nvim_set_keymap

local function append_to_qf(s)
  vim.fn.setqflist({ { text = s } }, 'a')
end

local function clear_qf()
  vim.fn.setqflist({}, 'r')
end

local function test_command()
  local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cursor_postion, _ = unpack(vim.api.nvim_win_get_cursor(0))

  clear_qf()

  -- local tokens = { 'describe', 'test', 'it' }
  local tokens = { 'GIVEN', 'THEN', 'WHEN', 'SCENARIO', 'AND_GIVEN', 'AND_WHEN', 'AND_THEN', 'SCENARIO_METHOD' }
  local count = 0
  local cases = {}
  local sections = {}
  local max_indent = 0
  for index, line in ipairs(content) do
    for _, token in ipairs(tokens) do
      local test_name = string.match(line, token .. [[%("(.*)"]])
      local indent = string.match(line, "(%s*)" .. token) -- 缩进
      if test_name then
        local indent_size = string.len(indent)
        count = count + 1
        table.insert(cases, { index, indent_size, test_name })
        if index <= cursor_postion then
          max_indent = indent_size
          sections[indent_size] = { index, indent_size, test_name }
        end
      end
    end
  end

  append_to_qf('Found ' .. count .. ' tests, running test:')
  for _, case in pairs(sections) do
    local line_number, indent_level, name = unpack(case)

    if line_number <= cursor_postion and indent_level <= max_indent then
      append_to_qf(string.rep(' ', indent_level) .. ' ' .. name)
    end
  end
end

vim.api.nvim_create_user_command("Test", test_command, {})

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

-- 上次文件后缀
local last_file_path = nil
local function jest_run()
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

  local cmd = [[TermExec cmd='cd ]] .. ts_config_path ..
      [[ && node "]] .. jest_bin_path .. [[" "]] .. current_file_path .. [[" -c "]] .. jest_config_path .. [["']]
  vim.cmd(cmd)
end

vim.api.nvim_create_user_command("JestRun", jest_run, {})

keymap('n', '<leader>rt', ":Test<cr>", opts)
