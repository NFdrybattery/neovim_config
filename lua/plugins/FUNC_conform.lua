return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    vscode = false,
    --event = "VeryLazy", -- 延迟加载
    opts = {
      formatters_by_ft = {
        python = { "yapf" }, -- Python 文件使用yapf格式化
      },
      formatters = {
        yapf = {
          args = { "--style=pyproject.toml" }, -- 移除--in-place参数
          prepend_args = {},                   -- 清空其他参数
        },
      },
    },
    keys = {
      {
        "<leader>cf", -- 快捷键
        function()
          require("conform").format() -- 调用 conform.nvim 的格式化函数
        end,
        desc = "格式化代码", -- 快捷键描述
      },
    },
  },
}
