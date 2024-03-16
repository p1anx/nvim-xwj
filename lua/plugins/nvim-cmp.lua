-- local ok, cmp = pcall(require, "cmp")
-- if not ok then
--   return
-- end
local kind_icons = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  -- Snippet = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}
return {
  "hrsh7th/nvim-cmp",
  dependecy = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          --[[ vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users. ]]
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              local buf = vim.api.nvim_get_current_buf()
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size > 1024 * 1024 then -- 1 Megabyte max
                return {}
              end
              return { buf }
            end,
          },
        },
        { name = "luasnip" }, -- For luasnip users.
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        --[[ { name = "vsnip" }, -- For vsnip users. ]]
        -- { name = "ultisnips" }, -- For ultisnips users.
        -- { name = "snippy" }, -- For snippy users.
        { name = "buffer" },
        { name = "path" },
        { name = "emoji" },
        { name = "treesitter" },
        -- { name = "crates" },
        -- { name = "tmux" },
        --  { name = "cmp_tabnine" },
        { name = "nvim_lsp_signature_help" },
        {
          name = "copilot",
          -- keyword_length = 0,
          max_item_count = 3,
          trigger_characters = {
            {
              ".",
              ":",
              "(",
              "'",
              '"',
              "[",
              ",",
              "#",
              "*",
              "@",
              "|",
              "=",
              "-",
              "{",
              "/",
              "\\",
              "+",
              "?",
              " ",
              -- "\t",
              -- "\n",
            },
          },
        },
      }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

          vim_item.menu = ({
            luasnip = "[Snippet]",
            --[[ vsnip = "[Snippet]", ]]
            nvim_lsp = "[LSP]",
            nvim_lua = "[NVIM_LUA]",
            buffer = "[Buffer]",
            path = "[Path]",
            emoji = "[Emoji]",
          })[entry.source.name]

          local source_mapping = {
            luasnip = "[Snippet]",
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            nvim_lua = "[Lua]",
            --[[ vsnip = "[Snippet]", ]]
            path = "[Path]",
            emoji = "[Emoji]",
            calc = "[Calc]",
            cmp_tabnine = "[Tabnine]",
            -- tmux = "(TMUX)",

            copilot = "[Copilot]",
            treesitter = "[TreeSitter]",
          }

          local menu = source_mapping[entry.source.name]
          vim_item.menu = menu

          return vim_item
        end,
      },
      -- confirm_opts = {
      --   behavior = cmp.ConfirmBehavior.Replace,
      --   select = false,
      -- },

      experimental = {

        ghost_text = false,

        native_menu = false,
      },
      -- duplicates = {
      --   buffer = 1,
      --   path = 1,
      --   nvim_lsp = 0,
      --   luasnip = 1,
      -- },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline({ "/", "?" }, {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = "buffer" },
    --   },
    -- })
    --
    -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --   }, {
    --     { name = "cmdline" },
    --   }),
    -- })
  end,
}
