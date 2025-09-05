return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    -- lazy = true,
    vscode = false,
    ft = {"markdown"},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      code = {
        sign = true,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      checkbox = {
        enabled = true,
      },
      bullet = {
        icons = {'', '', '', '', '','','' },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
        Snacks.toggle({
          name = "Render Markdown",
          get = function()
            return require("render-markdown.state").enabled
          end,
          set = function(enabled)
            local m = require("render-markdown")
            if enabled then
              m.enable()
            else
              m.disable()
            end
          end,
      }):map("<leader>um")
    end,
  }
}
