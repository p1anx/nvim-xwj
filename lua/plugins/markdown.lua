return {
  "plasticboy/vim-markdown",
  ft = { "markdown" },
  config = function()
    vim.cmd("let g:vim_markdown_toc_autofit = 1")
    vim.cmd("let g:vim_markdown_folding_disabled = 1")

  end
}
