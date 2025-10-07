local M = {}

-- 检测是否为 STM32 项目
function M.is_stm32_project()
  -- 检测 STM32 项目的特征文件
  local indicators = {
    "openocd.cfg",
    "STM32*.ld", -- 链接脚本
    ".stm32", -- 自定义标记文件
    "Core/Inc/stm32*.h", -- STM32 HAL 头文件
    "Startup/*.s", -- 启动文件
  }

  for _, pattern in ipairs(indicators) do
    if vim.fn.glob(pattern) ~= "" then
      return true
    end
  end

  return false
end

-- 获取构建目录
function M.get_build_dir()
  -- 优先查找常见的构建目录
  local build_dirs = { "build/default", "Build", "cmake-build-debug", "out" }

  for _, dir in ipairs(build_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      return dir
    end
  end

  return "build"
end

return M
