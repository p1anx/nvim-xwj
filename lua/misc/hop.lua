if true then
  return {}
end

return {
  "phaazon/hop.nvim",
  branch = "v2", -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("hop").setup({})
  end,
  keys = {
    { "<leader>h", "<cmd>HopChar1<cr>", desc = "HopChar1" },
    { "<leader>hw", "<cmd>HopWord<cr>", desc = "HopWord" },
  },
}
