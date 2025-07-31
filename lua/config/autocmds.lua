-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 自动切换到python文件夹
if vim.g.vscode == nil then
  local function delayed_action()
    vim.cmd("cd D:/40_Code/10_py/GroundTemperatureField") -- 切换目录
    --print("Current directory: " .. vim.fn.getcwd()) -- 打印当前目录
  end
  vim.defer_fn(delayed_action, 200) -- 延迟 0.2 秒执行
end

-- 检查是否在Neovide中运行
if vim.g.neovide then
  -- neovide自动输入法切换
  local function set_ime(args)
    if args.event:match("Enter$") then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end
  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
  })
  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
  })
end

if vim.g.vscode == nil then
  -- 自动格式化
  local set_autoformat = function(pattern, bool_val)
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = pattern,
      callback = function()
        vim.b.autoformat = bool_val
      end,
    })
  end
  set_autoformat({ "python" }, true)

-- 文件修改备份函数，兼容vscode/local_history插件
local function backup_file()
    if not vim.bo.modified then return end
    
    local current_file = vim.fn.expand("%:p")
    local timestamp = os.date("%Y%m%d%H%M%S")
    local file_name = vim.fn.expand("%:t:r")  -- 文件名（不含扩展名）
    local file_extension = vim.fn.expand("%:e") -- 扩展名
    
    -- 查找 .venv 目录
    local venv_dir = vim.fn.finddir(".venv", ".;")
    if venv_dir == "" then
        print("Error: .venv directory not found!")
        return
    end
    
    -- 获取项目根目录（.venv 的父目录）
    local project_root = vim.fn.fnamemodify(venv_dir, ":h")
    
    -- 标准化路径处理（Windows 兼容）
    local normalized_root = vim.fn.fnamemodify(project_root, ":p"):gsub("\\", "/")
    if normalized_root:sub(-1) ~= "/" then
        normalized_root = normalized_root .. "/"
    end
    
    local normalized_file = vim.fn.fnamemodify(current_file, ":p"):gsub("\\", "/")
    
    -- 提取相对路径（移除项目根目录前缀）
    if normalized_file:sub(1, #normalized_root) ~= normalized_root then
        print("Error: File not in project: " .. current_file)
        return
    end
    local relative_path = normalized_file:sub(#normalized_root + 1)
    
    -- 创建备份目录路径
    local backup_dir = normalized_root .. ".history/" .. vim.fn.fnamemodify(relative_path, ":h")
    
    -- 创建带时间戳的备份文件名
    local backup_file = backup_dir .. "/" .. file_name .. "_" .. timestamp
    if file_extension ~= "" then
        backup_file = backup_file .. "." .. file_extension
    end
    
    -- 创建目录（递归）
    if vim.fn.isdirectory(backup_dir) == 0 then
        vim.fn.mkdir(backup_dir, "p")
    end
    
    -- 执行备份
    vim.fn.writefile(vim.fn.readfile(current_file), backup_file)
    print("Backup saved to: " .. backup_file)
    
    -- 清除修改标志，避免无限循环
    vim.cmd("set nomodified")
end

-- 绑定自动命令（所有文件保存时触发）
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = backup_file,
})

end
