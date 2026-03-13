local M = {}

function M.sum_lines(opts)
  local start_line = opts.line1
  local end_line = opts.line2

  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  local start_col = start_pos[3]
  local end_col = end_pos[3]

  local vmode = vim.fn.visualmode()

  if start_col > end_col then
    start_col, end_col = end_col, start_col
  end

  local sum = 0
  for lnum = start_line, end_line do
    local line = vim.fn.getline(lnum)
    local segment

    if vmode == 'V' then
      -- linewise selection
      segment = line
    elseif vmode == '\22' then
      -- blockwise selection (Ctrl-v)
      local line_len = #line
      -- Gets line until the end if selection was incomplete
      local right = math.max(end_col, line_len)
      segment = line:sub(start_col, right)
    else
      -- characterwise selection
      if start_line == end_line then
        segment = line:sub(start_col, end_col)
      elseif lnum == start_line then
        segment = line:sub(start_col)
      elseif lnum == end_line then
        segment = line:sub(1, end_col)
      else
        segment = line
      end
    end

    local trimmed = segment:match '^%s*(.-)%s*$'

    if trimmed ~= '' then
      local n = tonumber(trimmed)
      if not n then
        error(("Failed to parse number on line %d: '%s'"):format(lnum, segment))
      end
      sum = sum + n
    end
  end

  print(sum)
end

return M
