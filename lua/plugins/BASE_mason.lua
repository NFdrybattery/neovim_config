-- mason插件管理
return {
  "mason-org/mason.nvim",
  version = "*",
  vscode = true,
  lazy = true,
  opts = {
    ensure_installed = {
      "python-lsp-server",
      "ruff",
      "yapf", 
    },
    ignore = {
      "markdown-toc", -- 禁止安装的组件
      "shfmt" -- 可扩展其他禁止项
    },
  },
}
