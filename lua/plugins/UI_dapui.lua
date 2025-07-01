-- 调试界面设置
return {
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    vscode = false,
    -- 使用DapStarted事件触发加载，避免循环依赖
    event = "User DapStarted",
    config = function()
      -- 添加错误处理
      local ok, dapui = pcall(require, "dapui")
      if not ok then
        vim.notify("Failed to load dap-ui: " .. dapui, vim.log.levels.ERROR)
        return
      end

      -- 带注释的详细配置
      dapui.setup({
        layouts = {
          -- 左侧面板配置
          {
            elements = {
              { id = "scopes", size = 0.60 },  -- 变量作用域面板
              { id = "breakpoints", size = 0.15 },  -- 断点面板
              { id = "stacks", size = 0.10 },  -- 调用栈面板
              { id = "watches", size = 0.15 },  -- 监视表达式面板
            },
            position = "left",  -- 显示在左侧
            size = 60,  -- 宽度60字符
          },
          -- 底部面板配置
          {
            elements = {
              { id = "repl", size = 0.5 },  -- 交互式REPL
              { id = "console", size = 0.5 },  -- 调试控制台
            },
            position = "bottom",  -- 显示在底部
            size = 10,  -- 高度10字符
          },
        },
      })
    end
  }
}
