return {
  -- Using Packer
  "navarasu/onedark.nvim",
  config = function()
    require("onedark").setup({
      style = "deep",
    })
  end,
  init = function()
    -- require("onedark").load()
    -- vim.cmd("colorscheme onedark")
  end,
}
