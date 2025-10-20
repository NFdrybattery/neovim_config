return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- version = "*",
    branch = 'main',
    vscode = false,
    lazy = false,
    build = ':TSUpdate', 
    config = function()
      require('nvim-treesitter').setup {
        ensure_installed = { "python", "markdown", "markdown_inline", "latex" },
        highlight = {
          enable = true,
          -- disable_on_undo = true,  -- 撤销时临时禁用高亮
          -- max_col_length = 1024,   -- 限制高亮列范围
          additional_vim_regex_highlighting = false,  -- 避免双重高亮
        },
      }
    end,
  }
}
