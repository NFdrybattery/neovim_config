-- bufferline缓冲区插件
return {
  'akinsho/bufferline.nvim',
  lazy = true,
  event = "BufWinEnter",
  vscode = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
  end,
  opts = {
    options = {
      mode = "buffers",
      themable = true,
	  numbers = "none",
      separator_style = "slant",
	  indicator = {
		icon = '▎',
		style = 'underline',
	  },
	  truncate_names = true,
	  show_buffer_icons = true,
	  show_buffer_close_icons = true,
	  show_close_icon = true,
      enforce_regular_tabs = true,
      always_show_bufferline = true,
	  auto_toggle_bufferline = true,
    },
  },
}
