-- mason插件管理
return {
    "mason-org/mason.nvim",
    vscode = true,
    lazy = true,
    opts = {
        ensure_installed = {
            "python-lsp-server",
            "ruff",
            --"jedi-language-server", 
            --"pyright",
            -- "yapf", 
        },
    },
}
