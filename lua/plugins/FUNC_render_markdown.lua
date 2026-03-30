return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    version = "*",
    -- lazy = true,
    vscode = false,
    ft = {"codecompanion", "markdown"},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- require('render-markdown').setup({
        enabled = true,
        preset = 'obsidian',
        file_types = {"codecompanion","markdown"},
        completions = {
          blink = { enabled = true },
        },
        pipe_table = {
          cell = "trimmed",
        }, 
      -- })
    }, 
  }
}
