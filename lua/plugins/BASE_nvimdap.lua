return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    vscode = false,
    ft = { "python" },
    keys = { "<leader>dd" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      -- 增加错误处理
      local ok, dapui = pcall(require, "dapui")
      if not ok then
        vim.notify("Failed to load dapui: " .. dapui, vim.log.levels.ERROR)
        return
      end

      -- 设置断点标记
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "ErrorMsg", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "WarningMsg", linehl = "", numhl = "" })
      
      -- 自动启动 DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
    end,
    keys={
      {
        '<leader>dc', "<cmd>lua vim.cmd('w') require('dap').continue()<CR>",desc="保存并调试", mode = { "n" }
      },
    }, 
  }, 
}
