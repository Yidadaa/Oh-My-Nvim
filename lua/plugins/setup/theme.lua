vim.cmd [[colorscheme tokyonight]]

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

local notify = require('notify')
local max_width = 100
notify.setup({ max_width = max_width, max_height = 5 })

local function split_length(s, n)
  local lines = {}
  local line = ""
  for word in s:gmatch("%S+") do
    if #line + #word + 1 > n then
      table.insert(lines, line)
      line = word
    elseif #line == 0 then
      line = word
    else
      line = line .. " " .. word
    end
  end
  if #line > 0 then
    table.insert(lines, line)
  end
  return lines
end

local function startswith(str, start)
  return str:sub(1, #start) == start
end

vim.notify = function(msg, level, opts)
  if type(msg) == "string" then
    -- filter guess indent message
    if startswith(msg, 'Did set indentation') or startswith(msg, 'Failed to detect indentation') then
      return
    end

    msg = vim.split(msg, "\n")
  end

  local truncated = {}
  for _, line in ipairs(msg) do
    local new_lines = split_length(line, max_width)
    for _, l in ipairs(new_lines) do
      truncated[#truncated + 1] = l
    end
  end
  return notify(truncated, level, opts)
end
