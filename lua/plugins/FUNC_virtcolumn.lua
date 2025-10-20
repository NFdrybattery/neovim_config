-- 行宽提示
return {
  {
    'lukas-reineke/virt-column.nvim',
    version = "*",
    lazy = true,
    vscode = false,
    ft = {"python"},
    -- event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
    config = function()
      require("virt-column").setup({
        virtcolumn = "+1, 130"
      })
    end
  }
}
