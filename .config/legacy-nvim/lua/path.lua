local pathUtils = {}

pathUtils.getData = function()
  return vim.fn.stdpath("data")
end

pathUtils.getConfig = function()
  return vim.fn.stdpath("config")
end

pathUtils.getCache = function()
  return vim.fn.stdpath("cache")
end

pathUtils.join = function(...)
  local path_sep = vim.loop.os_uname().version:match("Windows") and "\\" or "/"
  return table.concat({ ... }, path_sep)
end

return pathUtils