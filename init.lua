-- ============================================================================
-- neovim 配置入口
-- 支持 lazyvim 和 neovim 0.12+ 原生插件管理两种方案
-- ============================================================================

-- ==================== 配置开关 ====================
-- 设置为 true 使用原生方案，false 使用 lazyvim 方案
local use_native_plugins = false -- 修改此值切换方案

-- ==================== lazyvim 方案 ====================
if not use_native_plugins then
  require("config.lazy")
end

-- ==================== neovim 0.12+ 原生方案 ====================
if use_native_plugins then
  -- 启用原生插件加载器
  vim.loader.enable()
  
  -- 导入原生插件管理模块
  local native_plugins = require("plugins_native")
  
  -- 执行初始化
  native_plugins.setup()
  
  -- 打印当前方案提示
  vim.api.nvim_create_autocmd("vimenter", {
    callback = function()
      vim.schedule(function()
        vim.notify("✅ 使用 neovim 0.12+ 原生插件管理方案", vim.log.levels.info)
      end)
    end,
  })
end
