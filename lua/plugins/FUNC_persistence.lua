return {
  {
    "folke/persistence.nvim",
    lazy = true,
    opts = {
      options = { "buffers", "globals", "tabpages", "winsize" },
      -- 关键修复 1：强制统一会话路径格式
      pre_save = function()
        local session_name = vim.fn.fnamemodify(vim.v.this_session, ":t") -- 提取纯文件名
        vim.v.this_session = vim.fn.stdpath("data") .. "/sessions/" .. session_name
      end,
      -- 关键修复 2：覆盖加载逻辑
      load = function(session)
        require("persistence").stop()
        vim.cmd("silent! %bwipeout!") -- 清除当前缓冲区
        vim.cmd("source " .. vim.fn.fnameescape(session))
      end,
    },
  },
}
