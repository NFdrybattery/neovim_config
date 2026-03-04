return{
    "HiPhish/rainbow-delimiters.nvim", 
    -- version = "*",
    vscode = false,
    -- lazy = true,
    submodules = false, 
    event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
}