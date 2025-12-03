个人neovim插件与配置方案，基于lazyvim，win11系统。
重新部署使用如下命令：

```
// 备份当前配置
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
// 克隆配置文件
git clone https://github.com/NFdrybattery/nvim $env:LOCALAPPDATA\nvim
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
    - 自定义模型为DeepSeek，配置快捷键，启用对话记录
- windsurf.nvim
    - 关闭对话功能、关闭虚拟代码显示，配置blink.cmp
- blink.cmp
    - 配置补全框显示格式
- lazygit.nvim
    - 配置安装发布版
- nvim-lspconfig
    - 配置LSP服务器pylsp、ruff，并分别配置选项
- mason.nvim
    - 配置默认安装pylsp、ruff、yapf
- mason-lspconfig.nvim
    - 默认配置


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
