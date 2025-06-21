local M = {}
local uv = vim.loop
function M.get_os()
  local version = uv.os_uname().version

  if version:match 'Windows' then
    return 'Windows'
  elseif version:match 'Darwin' then
    return 'Mac'
  else
    return 'Linux'
  end
end

return M
