return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("telescope").setup()
    vim.keymap.set("n", "<leader>faC", function()
      require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true,
        -- cwd = "/"  -- 从根目录开始搜索（Linux/Mac）
        cwd = "C:\\"  -- Windows 用这个
      })
    end, { desc = "Find C files" })
    vim.keymap.set("n", "<leader>faD", function()
      require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true,
        -- cwd = "/"  -- 从根目录开始搜索（Linux/Mac）
        cwd = "D:\\"  -- Windows 用这个
      })
    end, { desc = "Find D files" })
  end
}