return {
  "nvim-treesitter/nvim-treesitter",
  vscode = false,
  lazy = true,
  build = function()
    vim.cmd("TSUpdate") -- 仅在安装时更新解析器
  end,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "markdown", "markdown_inline", "latex",
      },
      highlight = {
        enable = true,
      },
    })
  end,
}
