-- lualine状态栏插件
return {
  'nvim-lualine/lualine.nvim',
  version = "*",
  vscode = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    options = {
      theme = 'auto',
      component_separators = '',
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }, 
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
    local icons = {
      Error = { " ", "DiagnosticError" },
      Inactive = { " ", "MsgArea" },
      Warning = { " ", "DiagnosticWarn" },
      Normal = { LazyVim.config.icons.kinds.Copilot, "Special" },
    }
    table.insert(opts.sections.lualine_x, 2, {
      function()
        local status = require("sidekick.status").get()
        return status and vim.tbl_get(icons, status.kind, 1)
      end,
      cond = function()
        return require("sidekick.status").get() ~= nil
      end,
      color = function()
        local status = require("sidekick.status").get()
        local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(icons, status.kind, 2))
        return { fg = Snacks.util.color(hl) }
      end,
    })

    table.insert(opts.sections.lualine_x, 2, {
      function()
        local status = require("sidekick.status").cli()
        return " " .. (#status > 1 and #status or "")
      end,
      cond = function()
        return #require("sidekick.status").cli() > 0
      end,
      color = function()
        return { fg = Snacks.util.color("Special") }
      end,
    })
  end,
}
