-- masonlsp插件
return {
    "mason-org/mason-lspconfig.nvim",
    -- version = "*",  -- 会导致lsp错误
    vscode = true,
    lazy = true,
	dependencies = {
        "mason-org/mason.nvim",
    },
    opts = {},
}
