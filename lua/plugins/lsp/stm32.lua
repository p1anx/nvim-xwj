-- ===== 工具函数：检测项目类型 =====
local project = require("utils.project")
-- ===== 配置：STM32 调试 =====

-- if not project.is_stm32_project() then
--   return {}
-- else
--   vim.notify("This is STM32 Project")
-- end

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
    -- ===== 配置：STM32 调试 =====
    opts = function()
      local dap_cortex_debug = require("dap-cortex-debug")
      require("dap").configurations.c = {
        dap_cortex_debug.openocd_config({
          name = "STM32 Debug (OpenOCD)",
          cwd = "${workspaceFolder}",
          serverpath = "/bin/openocd",
          --检测项目中的elf文件
          executable = function()
            local build_dir = project.get_build_dir()
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
