return {
  'luozhiya/fittencode.nvim',
  lazy = true,
  vscode = false,
  event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
  config = function()
    require('fittencode').setup({
      -- 配置补全源
      sources = {
        lsp = false,              -- 启用 LSP 补全
        buffer = false,           -- 启用缓冲区补全
        path = false,             -- 启用路径补全
      },
      use_default_keymaps = false,
      keymaps = {
        inline = {
          ['<A-Down>'] = 'accept_all_suggestions',
          ['<A-L>'] = 'accept_line',
          ['<A-l>'] = 'accept_word',
          ['<A-Up>'] = 'revoke_line',
          ['<A-Left>'] = 'revoke_word',
          ['<A-\\>'] = 'triggering_completion',
        },
      }, 
      completion_mode = 'source',
      --completion_mode = 'inline',
      --inline_completion = {
        --enable = true, 
        --disable_completion_within_the_line = true,
        --disable_completion_when_delete = true,
      --}, 
      delay_completion = {
        delaytime = 1000,
      },
    })
  end,
}