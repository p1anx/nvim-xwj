local bufferline = require("bufferline")
vim.opt.termguicolors = true
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
      show_tab_indicators = true, -- true | false,
      indicator = {
        -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
        -- icon = "_", -- this should be omitted if indicator style is not 'icon'
        style = "underline", --'icon' | 'underline' | 'none',
      },
      separator_style = "thin", --"slant"| "slope" | "thick" | "thin" | { 'any', 'any' },
      always_show_bufferline = true,
    },
  },
}
