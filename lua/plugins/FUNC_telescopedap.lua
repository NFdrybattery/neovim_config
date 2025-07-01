return {
  {
    "nvim-telescope/telescope-dap.nvim",
    lazy = true,
    vscode = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
    keys={
      {
        '<leader>dv', '<cmd>Telescope dap variables<CR>',desc="变量面板", mode = { "n" }
      },
      {
        '<leader>dd', '<cmd>Telescope dap list_breakpoints<CR>',desc="断点面板", mode = { "n" }
      },
    }, 
  }
}
