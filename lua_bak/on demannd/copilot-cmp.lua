local config_cmp = function()
  require("copilot_cmp").setup()
end
return {
  "zbirenbaum/copilot-cmp",
  event = { "InsertEnter", "LspAttach" },
  fix_pairs = true,
  config = config_cmp,
}
