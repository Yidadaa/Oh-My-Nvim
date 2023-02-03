vim.cmd [[colorscheme tokyonight]]

require('lualine').setup {
  options = {
    theme = 'tokyonight'
  }
}

local notify = require('notify')
local max_width = 100
notify.setup({ max_width = max_width, max_height = 5 })

local function split_length(text, length)
  local lines = {}
  local next_line
  while true do
    if #text == 0 then
      return lines
    end
    next_line, text = text:sub(1, length), text:sub(length)
    lines[#lines + 1] = next_line
  end
end

vim.notify = function(msg, level, opts)
  if type(msg) == "string" then
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
