-- 行宽提示
return {
  {
    'lukas-reineke/virt-column.nvim',
    lazy = true,
    vscode = false,
    --event = "VeryLazy", -- 延迟加载
    event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
    config = function()
      require("virt-column").setup({
        virtcolumn = "+1, 130"
      })
    end
  }
}
