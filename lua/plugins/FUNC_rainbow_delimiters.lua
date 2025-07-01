return{
	"HiPhish/rainbow-delimiters.nvim", 
	vscode = false,
	lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
}