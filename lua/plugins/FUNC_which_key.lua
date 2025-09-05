-- 按键提示
return{
  "folke/which-key.nvim",
  -- version = "*",
  --lazy = true,
  --event = "VeryLazy", -- 延迟加载
  keys = {"<leader>" },
  -- vscode = false,
  opts = {
    spec ={
      {
        { "<leader>y", desc = "剪切板", icon = "" },
        --{ "<leader>uv", desc = "变量显示", icon = "󰫧" },
        -- CodeCompanion
        { "<leader>a", group = "Chat", icon = " "},
        { "<leader>aa", desc = "问答", icon = "󰭻" }, 
        { "<leader>an", desc = "新问答", icon = "󱐏" },
        { "<leader>ah", desc = "历史", icon = "" }, 
        { "<leader>aA",desc = "动作", icon = "󰮫" }, 
      }, 
    }, 
  }, 
}
