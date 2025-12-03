return {
  "stevearc/conform.nvim",
  version = "*",
  lazy = true,
  vscode = false,
  opts = function()
    return {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        markdown = {
          "markdownlint-cli2",
          extra_args = function()
            return {
              "--config",
              [[{
                "config": {
                  "MD001": false,
                  "MD041": false,
                  "no-inline-html": false
                },
                "frontMatter": {
                  "type": "yaml",
                  "start": "---",
                  "end": "---",
                  "skip": true
                }
              }]],
              "--fix"
            }
          end,
        },
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
