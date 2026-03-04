return {
  "stevearc/conform.nvim",
  version = "*",
  lazy = true,
  vscode = false,
  opts = function()
    return {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        markdown = { "prettier" },
      },
      formatters = {
        ruff_format = {
          command = "ruff",
          args = {
            "format",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
          stdin = true,
        },
        ruff_fix = {
          command = "ruff",
          args = {
            "check",
            "--stdin-filename",
            "$FILENAME",
            "--fix",
            "-",
          },
          stdin = true,
        },
        prettier = {
          command = "prettier",
          args = {
            "--stdin-filepath",
            "$FILENAME",
            "--tab-width",
            "4",
            "--print-width",
            "80",
          },
          stdin = true,
        },
      },
    }
  end,
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format()
      end,
      desc = "格式化代码",
    },
  },
}
