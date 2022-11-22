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

keymap('n', '<leader>rt', ":Test<cr>", opts)
