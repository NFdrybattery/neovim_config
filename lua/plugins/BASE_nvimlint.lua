return {
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    vscode = false,
    --event = "VeryLazy", -- 延迟加载
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" }, -- 使用 Ruff进行代码检查
      }
    end,
  },
}