local dap = require("dap")
local dapui = require("dapui")

-- -- -- ===== 快捷键设置 =====
-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
--
-- -- 基本调试控制
-- keymap("n", "<F9>", dap.continue, opts)
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

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  },
}
