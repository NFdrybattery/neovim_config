-- 自动切换根目录
return {
  "wsdjeg/rooter.nvim",
  lazy = true,
  vscode = false,
  event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
  config = function()
	require('rooter').setup({
	  root_pattern = { '.git/',"pyproject.toml" },
	})
  end,
}

