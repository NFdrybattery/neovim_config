-- mason插件管理
return {
    "mason-org/mason.nvim",
    vscode = true,
    lazy = true,
    opts = {
        ensure_installed = {
            "ruff",
            "pylsp",
        },
    },
}
