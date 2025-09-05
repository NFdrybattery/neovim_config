-- windsurf插件
return {
  {
    "Exafunction/windsurf.nvim",
    -- version = "*",
    -- lazy = true,
    vscode = false,
    -- ft = {"python"},
    event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
    dependencies = {
          "nvim-lua/plenary.nvim",
          -- "hrsh7th/nvim-cmp",
          "saghen/blink.cmp", 
      },
    config = function()
      require("codeium").setup({
        enable_chat = false,
        enable_cmp_source = false,
        virtual_text = {
          enabled = false,
        },
      })
    end, 
  }
}
