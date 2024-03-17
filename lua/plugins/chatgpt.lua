return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup({
      -- api_host_cmd = "https://api.chatanywhere.tech",
      -- api_key_cmd = "sk-K54UmZ1y9zZ87HZMpPAj0GxihcAUlQ2d5d9nfJj5KymBg0eM",
      -- extra_curl_params = {
      --   "-H",
      --   "https://api.chatanywhere.tech",
      -- },
      -- api_key_cmd = "op read op:sk-K54UmZ1y9zZ87HZMpPAj0GxihcAUlQ2d5d9nfJj5KymBg0eM --no-newline",
      -- api_type_cmd = "open ai",
      -- azure_api_base_cmd = "echo https://api.chatanywhere.tech",
      -- azure_api_engine_cmd = "echo chat",
      -- azure_api_version_cmd = "echo 2023-05-15",
      chat = {
        welcome_message = WELCOME_MESSAGE,
        loading_text = "Loading, please wait ...",
        question_sign = "", -- 🙂
        answer_sign = "🤖", -- ﮧ
        border_left_sign = "",
        border_right_sign = "",
        max_line_length = 120,
        sessions_window = {
          active_sign = "  ",
          inactive_sign = "  ",
          current_line_sign = "",
          border = {
            style = "rounded",
            text = {
              top = " Sessions ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
      },
      openai_params = {
        model = "gpt-3.5-turbo",
        -- model = "gpt-4-1106-preview",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 3000,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
