-- lualine状态栏插件
return {
  'nvim-lualine/lualine.nvim',
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
  end,
}
