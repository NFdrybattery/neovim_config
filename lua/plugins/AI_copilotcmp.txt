-- Copilot_cmp
return {
  {
    "zbirenbaum/copilot-cmp",
    -- version = "*",
    lazy = true,
    vscode = false,
    -- event = "VeryLazy", -- 延迟加载
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
}