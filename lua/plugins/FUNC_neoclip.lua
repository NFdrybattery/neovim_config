-- 剪切板历史记录插件
return {
  {
    "AckslD/nvim-neoclip.lua",
    lazy = true,
    vscode = false,
    --event = "VeryLazy", -- 延迟加载
    event = { "BufReadPre", "BufNewFile" }, -- 确保插件在打开文件时加载
    dependencies = {
      {'kkharji/sqlite.lua', module = 'sqlite'},
      {'nvim-telescope/telescope.nvim'},
    },
    opts = {
      filter = function(data)
        -- 不记录覆盖操作（如 `c`、`s` 等命令）
        return not (data.event.operator == "c" or data.event.operator == "s" or data.event.operator == "d")
      end
    }, 
    keys={
      {
        '<leader>y', '<cmd>Telescope neoclip<CR>',desc="剪切板", mode = { "n","v" }
      },
    }, 
  }, 
}
