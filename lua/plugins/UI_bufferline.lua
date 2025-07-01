-- bufferline缓冲区插件
return {
  'akinsho/bufferline.nvim',
  lazy = true,
  event = "BufWinEnter",
  vscode = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  -- config = function(_, opts)
  --   require('bufferline').setup(opts)
  -- end,
  -- opts = {
  --   options = {
  --     mode = "tabs",
  --     style_preset = {
  --       bufferline.nvim.style_preset.no_italic,
  --       bufferline.nvim.style_preset.no_bold,
  --     },
  --     themable = true,
  --     separator_style = "slant",
  --     enforce_regular_tabs = true,
  --     always_show_bufferline = true,
  --   },
  -- },
}
