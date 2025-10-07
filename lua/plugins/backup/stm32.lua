-- ===== 工具函数：检测项目类型 =====
local function is_stm32_project()
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

  -- 检查 CMakeLists.txt 中是否包含 ARM 工具链
  -- local cmake_file = "CMakeLists.txt"
  -- if vim.fn.filereadable(cmake_file) == 1 then
  --   local content = table.concat(vim.fn.readfile(cmake_file), "\n")
  --   if content:match("arm%-none%-eabi") or content:match("cortex%-m") then
  --     return true
  --   end
  -- end

  return false
end

local function get_build_dir()
  -- 优先查找常见的构建目录
  local build_dirs = { "build/default", "Build", "cmake-build-debug", "out" }
  for _, dir in ipairs(build_dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      return dir
    end
  end
  return "build"
end
--
-- -- -- ===== GDB 适配器（通用） =====
-- -- dap.adapters.gdb = {
-- --   type = "executable",
-- --   command = "gdb",
-- --   args = { "-i", "dap" },
-- -- }
-- --
-- -- ARM GDB 适配器（STM32）
-- -- dap.adapters.gdb_arm = {
-- --   type = "executable",
-- --   command = "gdb-multiarch",
-- --   args = { "-i", "dap" },
-- -- }
--
-- ===== 配置：普通 C/C++ 程序 =====
local c_configs = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      local default_path = vim.fn.getcwd() .. "/" .. get_build_dir() .. "/"
      return vim.fn.input("Path to executable: ", default_path, "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
  {
    name = "Launch (Current File)",
    type = "gdb",
    request = "launch",
    program = function()
      -- 自动编译当前文件
      local file = vim.fn.expand("%:p")
      local output = vim.fn.expand("%:p:r")
      vim.fn.system(string.format('gcc -g "%s" -o "%s"', file, output))
      return output
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

-- ===== 配置：STM32 调试 =====

-- local dap_cortex_debug = require("dap-cortex-debug")
-- require("dap").configurations.c = {
--   dap_cortex_debug.openocd_config({
--     name = "Debugging with OpenOCD",
--     cwd = "${workspaceFolder}",
--     serverpath = "/bin/openocd",
--     executable = "${workspaceFolder}/build/default/ads1256_cmake.elf",
--     configFiles = { "${workspaceFolder}/openocd.cfg" },
--     gdbTarget = "localhost:3333",
--     rttConfig = dap_cortex_debug.rtt_config(0),
--     showDevDebugOutput = false,
--     -- showDevDebugOutput = "raw",
--   }),
-- }
-- local stm32_configs = {
--   {
--     name = "STM32 Debug (OpenOCD)",
--     type = "gdb_arm",
--     request = "launch",
--     program = function()
--       local build_dir = get_build_dir()
--       local default_path = vim.fn.getcwd() .. "/" .. build_dir .. "/"
--       local elf_files = vim.fn.glob(default_path .. "*.elf", false, true)
--
--       if #elf_files == 1 then
--         return elf_files[1]
--       end
--
--       return vim.fn.input("Path to ELF: ", default_path, "file")
--     end,
--   },
--   {
--     name = "STM32 Attach (OpenOCD)",
--     type = "gdb_arm",
--     request = "attach",
--     program = function()
--       local build_dir = get_build_dir()
--       return vim.fn.input("Path to ELF: ", vim.fn.getcwd() .. "/" .. build_dir .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     miDebuggerServerAddress = "localhost:3333",
--     miDebuggerPath = "gdb-multiarch",
--   },
-- }

-- ===== 动态设置配置 =====
-- 根据项目类型自动选择配置
-- if is_stm32_project() then
--   dap.configurations.c = stm32_configs
--   dap.configurations.cpp = stm32_configs
--   vim.notify("STM32 Debug Mode Enabled", vim.log.levels.INFO)
-- else
--   dap.configurations.c = native_configs
--   dap.configurations.cpp = native_configs
--   vim.notify("Native Debug Mode Enabled", vim.log.levels.INFO)
-- end
--
-- -- ===== 快捷键设置 =====
-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
--
-- -- 基本调试控制
-- keymap("n", "<F5>", dap.continue, opts)
-- keymap("n", "<F10>", dap.step_over, opts)
-- keymap("n", "<F11>", dap.step_into, opts)
-- keymap("n", "<F12>", dap.step_out, opts)
-- keymap("n", "<Leader>b", dap.toggle_breakpoint, opts)
-- keymap("n", "<Leader>B", function()
--   dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
-- end, opts)
--
-- -- UI 控制
-- keymap("n", "<Leader>du", dapui.toggle, opts)
-- keymap("n", "<Leader>dr", dap.repl.open, opts)
-- keymap("n", "<Leader>dt", dap.terminate, opts)
--
-- -- 切换调试模式
-- keymap("n", "<Leader>ds", function()
--   if is_stm32_project() then
--     dap.configurations.c = native_configs
--     vim.notify("Switched to Native Debug Mode", vim.log.levels.INFO)
--   else
--     dap.configurations.c = stm32_configs
--     vim.notify("Switched to STM32 Debug Mode", vim.log.levels.INFO)
--   end
-- end, opts)
--
-- print("DAP configuration loaded with auto-detection")
if not is_stm32_project() then
  return
else
  vim.notify("This is STM32 Project")
end
return {
  {
    "jedrzejboczar/nvim-dap-cortex-debug",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-cortex-debug").setup({
        debug = false, -- log debug messages
        -- path to cortex-debug extension, supports vim.fn.glob
        -- by default tries to guess: mason.nvim or VSCode extensions
        extension_path = nil,
        lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
        node_path = "node", -- path to node.js executable
        dapui_rtt = true, -- register nvim-dap-ui RTT element
        -- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
        dap_vscode_filetypes = { "c", "cpp" },
        rtt = {
          buftype = "Terminal", -- 'Terminal' or 'BufTerminal' for terminal buffer vs normal buffer
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      -- Ensure C/C++ debugger is installed
      "mason-org/mason.nvim",
      optional = true,
      -- opts = { ensure_installed = { "codelldb" } },
      opts = { ensure_installed = { "cortex-debug" } },
    },
    opts = function()
      local dap_cortex_debug = require("dap-cortex-debug")
      require("dap").configurations.c = {
        dap_cortex_debug.openocd_config({
          name = "STM32 Debug (OpenOCD)",
          cwd = "${workspaceFolder}",
          serverpath = "/bin/openocd",
          --检测项目中的elf文件
          executable = function()
            local build_dir = get_build_dir()
            local default_path = vim.fn.getcwd() .. "/" .. build_dir .. "/"
            local elf_files = vim.fn.glob(default_path .. "*.elf", false, true)

            if #elf_files == 1 then
              return elf_files[1]
            end
          end,

          -- "${workspaceFolder}/build/default",
          -- executable = "${workspaceFolder}/build/default/ads1256_cmake.elf",
          configFiles = { "${workspaceFolder}/openocd.cfg" },
          gdbTarget = "localhost:3333",
          rttConfig = dap_cortex_debug.rtt_config(0),
          showDevDebugOutput = false,
          -- showDevDebugOutput = "raw",
        }),
      }
    end,
  },
}
