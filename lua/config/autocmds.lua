-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 自动切换到 python 文件夹
if vim.g.vscode == nil and vim.g.neovide then
  local function delayed_action()
    vim.cmd("cd D:\\40_Code\\10_py\\GroundTemperatureField") -- 切换目录
    --print("Current directory: " .. vim.fn.getcwd()) -- 打印当前目录
  end
  vim.defer_fn(delayed_action, 200) -- 延迟 0.2 秒执行
end

-- md 文件关闭拼写检查
if vim.g.vscode == nil then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.spell = false  -- 关闭拼写检查
    end,
  })
end

-- Neovide 自动输入法切换：常规窗口根据编辑模式切换，terminal 窗口保持输入法常开
if vim.g.neovide then
  -- 标记 terminal buffer（使用 buffer 局部变量）
  vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
      vim.b.neovide_ime_terminal = true
    end,
  })

  -- 设置输入法状态
  local function set_ime(args)
    local is_term = vim.b.neovide_ime_terminal
    local enter_event = args.event:match("Enter$") ~= nil
    
    -- terminal 窗口保持输入法常开
    if is_term then
      vim.g.neovide_input_ime = true
      return
    end
    
    -- 常规窗口：Enter 结尾的事件表示进入某模式，启用输入法；否则禁用
    vim.g.neovide_input_ime = enter_event
  end

  -- 进入 buffer 时初始化输入法状态
  local function on_buf_enter()
    if vim.b.neovide_ime_terminal then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

  -- 插入模式切换
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
  })

  -- 命令行模式切换
  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
  })

  -- Buffer 进入时初始化输入法状态
  vim.api.nvim_create_autocmd("BufEnter", {
    group = ime_input,
    pattern = "*",
    callback = on_buf_enter
  })
end

-- 自动监测文件类型切换缩进方案，默认 4 空格
-- lua/config/indent.lua
local indent_rules = {
  -- 格式：[filetype] = { expandtab, tabstop, shiftwidth, softtabstop }
  markdown = { true, 4, 4, 4 },
  python   = { true,  4, 4, 4 },  -- PEP8 标准
  rust     = { true,  4, 4, 4 },  -- Rust 官方风格
  lua      = { true,  2, 2, 2 },  -- LazyVim 惯例
  -- 更多类型可在此扩展...
}

-- 默认配置 (未列出的文件类型使用此配置)
local default_rule = { true, 4, 4, 4 }  -- 默认 4 空格

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  desc = "Auto detect indentation rules",
  callback = function()
    local ft = vim.bo.filetype
    -- 获取匹配规则 (优先精确匹配，后尝试通配如 *.vue)
    local rule = indent_rules[ft] or default_rule

    -- 应用配置
    vim.bo.expandtab = rule[1]
    vim.bo.tabstop = rule[2]
    vim.bo.shiftwidth = rule[3]
    vim.bo.softtabstop = rule[4]

    -- 可选：调试日志
    -- print(string.format("Indent: %s %d (%s)",
    --   rule[1] and "spaces" or "tabs", rule[2], ft))
  end
})

-- 可选：添加状态栏显示
-- vim.api.nvim_create_autocmd("OptionSet", {
  -- pattern = { "expandtab", "shiftwidth" },
  -- callback = function()
    -- vim.opt.statusline = "%{&expandtab?'Spaces':'Tabs'}:%{&shiftwidth}"
  -- end
-- })
