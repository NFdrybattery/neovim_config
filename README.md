个人neovim插件与配置方案，基于lazyvim，win11系统。
重新部署使用如下命令：

```
// 备份当前配置
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
// 克隆配置文件
git clone https://github.com/NFdrybattery/neovim_config $env:LOCALAPPDATA\nvim
```

# 插件自定义情况
## 补充插件
- codecompanion.nvim
    - AI助手插件，支持自定义api，目前仅启用其对话功能，使用DeepSeek API
- windsurf.nvim
    - AI代码补全插件，结合blink配置
- simple_backup.nvim
    - 简单备份插件，保存时自动备份当前文件，支持vscode的localhistory

## 自定义插件
- codecompanion.nvim
    - 自定义模型为DeepSeek，配置中文语言、系统提示
    - 配置快捷键（<Leader>aa：切换聊天，<Leader>an：新建聊天，<Leader>ah：聊天记录）
    - 启用对话记录，配置自动保存、过期时间
    - 配置聊天窗口布局（垂直左侧，宽度0.25）
- windsurf.nvim
    - 关闭对话功能、关闭虚拟代码显示，配置blink.cmp
    - 启用版本控制，配置plenary.nvim依赖
- blink.cmp
    - 配置补全框显示格式，支持多种补全源
    - 配置模糊搜索，按键映射
- lazygit.nvim
    - 配置安装发布版
- nvim-lspconfig
    - 配置LSP服务器pylsp、ruff，并分别配置选项
    - 配置诊断、内联提示、代码镜头、折叠等功能
    - 配置LSP快捷键映射
- mason.nvim
    - 配置默认安装pylsp、ruff
- mason-lspconfig.nvim
    - 默认配置
- simple_backup.nvim
    - 配置备份目录为.history
    - 仅备份python和C文件（*.py, *.c）
- snacks.nvim
    - 启用多种功能：bigfile、dashboard、explorer、indent、input、notifier等
    - 配置大量快捷键，包括文件搜索、缓冲区管理、Grep搜索等
    - 配置LSP相关快捷键，如gd（跳转到定义）、gr（引用）等
    - 配置调试全局变量dd和bt
- conform.nvim
    - 配置Python文件使用ruff_format和ruff_fix格式化
    - 配置Markdown文件使用markdownlint-cli2格式化，自定义配置（禁用MD001、MD041，允许内联HTML）
    - 配置快捷键<leader>cf用于格式化代码
- rainbow-delimiters.nvim
    - 启用彩虹括号功能，用于增强代码可读性
    - 配置在打开文件时加载


## 禁用插件
- mini.comment - 注释插件
- sqlite.lua - SQLite 库
- nvim-treesitter-textobjects - 代码文本对象
- nvim-ts-context-commentstring - 上下文注释字符串
- nvim-ts-autotag - 自动标签闭合
- friendly-snippets - 代码片段集
- nvim-snippets - 代码片段
- cmp-path - 路径补全
- markdown-preview.nvim - Markdown 预览
- copilot-cmp - Copilot 补全集成（不稳定）
- copilot.lua - GitHub Copilot
- CopilotChat.nvim - Copilot 聊天集成
