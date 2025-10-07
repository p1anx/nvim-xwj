-- return {
--   require("lspconfig").clangd.setup({
--     cmd = {
--       "clangd",
--       "--header-insertion=never", -- 禁用头文件自动插入
--       "--suggest-missing-includes=false", -- 禁用缺失包含建议
--     },
--   }),
-- }
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "clangd", "--header-insertion=never" }, -- 禁用头文件自动插入
          on_attach = function(client, bufnr)
            -- 启用自动格式化功能
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end,
          settings = {
            clangd = {
              fallbackFlags = { "--style=file" }, -- 确保使用 .clang-format
            },
          },
        },
      },
    },
  },
}
