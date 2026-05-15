-- Neovim 0.12+ 原生插件管理配置
-- 此文件用于在 Neovim 0.12+ 中使用原生插件管理机制
-- 替代 lazy.nvim + LazyVim 方案

local M = {}

-- ============================================================================
-- 插件定义列表 (按功能分类)
-- ============================================================================

M.plugins = {
  -- ==================== 基础工具 ====================
  
  -- plenary.nvim - Lua 工具库
  {
    name = "plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim",
    event = "VeryLazy",
  },
  
  -- nvim-nio - Nvim I/O 抽象层
  {
    name = "nvim-nio",
    url = "https://github.com/nvim-neotest/nvim-nio",
    event = "VeryLazy",
  },
  
  -- nui.nvim - UI 组件库
  {
    name = "nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim",
    event = "VeryLazy",
  },
  
  -- nvim-web-devicons - 文件类型图标
  {
    name = "nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
  },
  
  -- mini.icons - 图标管理
  {
    name = "mini.icons",
    url = "https://github.com/echasnovski/mini.icons",
    event = "VeryLazy",
  },
  
  -- ts-comments.nvim - Treesitter 注释
  {
    name = "ts-comments.nvim",
    url = "https://github.com/jose-elias-alvarez/ts-comments.nvim",
    event = "VeryLazy",
  },
  
  -- dressing.nvim - 表单美化
  {
    name = "dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  
  -- vim-illuminate - 单词高亮
  {
    name = "vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  
  -- gitsigns.nvim - Git 行内标记
  {
    name = "gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim",
    event = "GitFile",
  },
  
  -- mini.pairs - 括号配对
  {
    name = "mini.pairs",
    url = "https://github.com/echasnovski/mini.pairs",
    event = "InsertEnter",
  },
  
  -- rainbow-delimiters.nvim - 括号高亮
  {
    name = "rainbow-delimiters.nvim",
    url = "https://github.com/HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPre",
  },
  
  -- virt-column.nvim - 行宽提示线
  {
    name = "virt-column.nvim",
    url = "https://github.com/lukas-reineke/virt-column.nvim",
    ft = "python",
  },
  
  -- render-markdown.nvim - Markdown 渲染
  {
    name = "render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    ft = {"markdown", "codecompanion"},
    dependencies = {"nvim-treesitter/nvim-treesitter"},
  },
  
  -- simple-backup.nvim - 文件自动备份
  {
    name = "simple-backup.nvim",
    url = "https://github.com/NFdrybattery/simple-backup.nvim",
    event = "BufWritePre",
  },
  
  -- persistence.nvim - 会话保存
  {
    name = "persistence.nvim",
    url = "https://github.com/folke/persistence.nvim",
    event = "VeryLazy",
  },
  
  -- ==================== LSP 相关 ====================
  
  -- mason.nvim - 语言服务器管理器
  {
    name = "mason.nvim",
    url = "https://github.com/williamboman/mason.nvim",
    event = "VeryLazy",
  },
  
  -- mason-lspconfig.nvim - Mason + LSP 集成
  {
    name = "mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {"mason-org/mason.nvim"},
  },
  
  -- nvim-lspconfig - LSP 服务器配置
  {
    name = "nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {"mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim"},
  },
  
  -- nvim-lint - 异步 linting
  {
    name = "nvim-lint",
    url = "https://github.com/mfussenegger/nvim-lint",
    event = "VeryLazy",
  },
  
  -- nvim-treesitter - 语法高亮/代码分析
  {
    name = "nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter",
    event = {"LazyFile", "VeryLazy"},
  },
  
  -- ==================== 补全相关 ====================
  
  -- blink.cmp - 智能补全引擎
  {
    name = "blink.cmp",
    url = "https://github.com/saghen/blink.cmp",
    event = "InsertEnter",
  },
  
  -- codeium.vim - Codeium 补全 (windsurf.nvim 依赖)
  {
    name = "codeium.vim",
    url = "https://github.com/exafunction/codeium.vim",
    event = "BufReadPre",
  },
  
  -- ==================== 搜索相关 ====================
  
  -- telescope.nvim - 模糊搜索
  {
    name = "telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-lua/plenary.nvim"},
  },
  
  -- todo-comments.nvim - TODO 标签标记
  {
    name = "todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = {"nvim-lua/plenary.nvim"},
  },
  
  -- grug-far.nvim - 全局查找替换
  {
    name = "grug-far.nvim",
    url = "https://github.com/AckslD/grug-far.nvim",
    event = "VeryLazy",
  },
  
  -- ==================== UI 相关 ====================
  
  -- bufferline.nvim - 标签页栏
  {
    name = "bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim",
    event = "BufWinEnter",
    dependencies = {"nvim-tree/nvim-web-devicons"},
  },
  
  -- lualine.nvim - 状态栏
  {
    name = "lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-tree/nvim-web-devicons"},
  },
  
  -- noice.nvim - 消息界面
  {
    name = "noice.nvim",
    url = "https://github.com/folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {"MunifTanjim/nui.nvim"},
  },
  
  -- which-key.nvim - 按键提示
  {
    name = "which-key.nvim",
    url = "https://github.com/folke/which-key.nvim",
    event = "VeryLazy",
  },
  
  -- flash.nvim - 字符跳转查找
  {
    name = "flash.nvim",
    url = "https://github.com/folke/flash.nvim",
    event = "VeryLazy",
  },
  
  -- mini.ai - 文本对象选择
  {
    name = "mini.ai",
    url = "https://github.com/echasnovski/mini.ai",
    event = "VeryLazy",
  },
  
  -- trouble.nvim - 问题列表
  {
    name = "trouble.nvim",
    url = "https://github.com/folke/trouble.nvim",
    event = "VeryLazy",
  },
  
  -- ==================== 调试相关 ====================
  
  -- nvim-dap - 调试器协议
  {
    name = "nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap",
    event = "VeryLazy",
  },
  
  -- nvim-dap-ui - 调试 UI
  {
    name = "nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui",
    event = "User DapStarted",
    dependencies = {"mfussenegger/nvim-dap"},
  },
  
  -- nvim-dap-python - Python 调试支持
  {
    name = "nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap"},
  },
  
  -- nvim-dap-virtual-text - 调试变量虚拟文本
  {
    name = "nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap"},
  },
  
  -- telescope-dap.nvim - DAP + Telescope 集成
  {
    name = "telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap"},
  },
  
  -- mason-nvim-dap.nvim - Mason + DAP 集成
  {
    name = "mason-nvim-dap.nvim",
    url = "https://github.com/williamboman/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {"mason-org/mason.nvim", "mfussenegger/nvim-dap"},
  },
  
  -- ==================== AI 助手相关 ====================
  
  -- codecompanion.nvim - AI 代码助手
  {
    name = "codecompanion.nvim",
    url = "https://github.com/olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
  },
  
  -- codecompanion-history.nvim - 对话历史
  {
    name = "codecompanion-history.nvim",
    url = "https://github.com/CodeCompanion-Nvim/codecompanion-history.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
  },
  
  -- sidekick.nvim - Qwen CLI 工具
  {
    name = "sidekick.nvim",
    url = "https://github.com/folke/sidekick.nvim",
    event = "VeryLazy",
  },
  
  -- windsurf.nvim - Codeium 集成
  {
    name = "windsurf.nvim",
    url = "https://github.com/Exafunction/windsurf.nvim",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"nvim-lua/plenary.nvim", "saghen/blink.cmp"},
  },
  
  -- ==================== 其他工具 ====================
  
  -- lazygit.nvim - Git 图形界面
  {
    name = "lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim",
    cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile"},
    dependencies = {"nvim-lua/plenary.nvim"},
  },
  
  -- conform.nvim - 代码格式化
  {
    name = "conform.nvim",
    url = "https://github.com/stevearc/conform.nvim",
    event = "VeryLazy",
  },
  
  -- yazi.nvim - 文件管理器
  {
    name = "yazi.nvim",
    url = "https://github.com/mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-lua/plenary.nvim"},
  },
  
  -- snacks.nvim - 工具集合
  {
    name = "snacks.nvim",
    url = "https://github.com/folke/snacks.nvim",
    event = "VeryLazy",
  },
  
  -- nvim-neoclip.lua - 剪贴板历史
  {
    name = "nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua",
    event = "VeryLazy",
    dependencies = {
      {"kkharji/sqlite.lua", module = "sqlite"},
      {"nvim-telescope/telescope.nvim"},
    },
  },
  
  -- tokyonight.nvim - 配色方案
  {
    name = "tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim",
    event = "VeryLazy",
  },
}

-- ============================================================================
-- 插件安装函数
-- ============================================================================

M.install_plugins = function()
  local install_dir = vim.fn.stdpath("data") .. "/site/pack/plugin/start"
  local has_git = vim.fn.executable("git") == 1
  
  if not has_git then
    vim.notify("Git not found, cannot install plugins", vim.log.levels.ERROR)
    return
  end
  
  for _, plugin in ipairs(M.plugins) do
    local plugin_dir = install_dir .. "/" .. plugin.name
    local exists = vim.loop.fs_stat(plugin_dir)
    
    if not exists then
      vim.notify("Installing " .. plugin.name, vim.log.levels.INFO)
      local cmd = {"git", "clone", "--depth", "1", plugin.url, plugin_dir}
      local success, err = pcall(function()
        vim.fn.system(cmd)
      end)
      
      if not success then
        vim.notify("Failed to install " .. plugin.name .. ": " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end
end

-- ============================================================================
-- 插件加载函数
-- ============================================================================

M.load_plugin = function(plugin_name)
  local packpath = vim.fn.stdpath("data") .. "/site"
  local plugin_path = packpath .. "/pack/plugin/start/" .. plugin_name
  
  if vim.loop.fs_stat(plugin_path) then
    vim.opt.rtp:prepend(plugin_path)
    require(plugin_name)
    return true
  else
    vim.notify("Plugin not installed: " .. plugin_name, vim.log.levels.WARN)
    return false
  end
end

-- ============================================================================
-- 事件监听注册
-- ============================================================================

M.setup_autocmds = function()
  -- 启动时检查并安装插件
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- 延迟执行，避免阻塞启动
      vim.schedule(function()
        M.install_plugins()
      end)
    end,
  })
end

-- ============================================================================
-- 主配置函数
-- ============================================================================

M.setup = function()
  -- 启用原生插件加载器
  vim.loader.enable()
  
  -- 设置自动命令
  M.setup_autocmds()
  
  -- 打印提示
  vim.notify("Neovim 0.12+ 原生插件管理已启用", vim.log.levels.INFO)
end

return M
