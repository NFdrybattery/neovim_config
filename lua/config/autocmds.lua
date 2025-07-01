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
    vim.cmd("cd D:\\40_Code\\10_py\\py313") -- 切换目录
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

  -- 自动备份函数
  local function backup_file()
    local current_file = vim.fn.expand("%:p")                                        -- 获取当前文件的完整路径
    local parent_dir = vim.fn.fnamemodify(current_file, ":h")                        -- 父目录
    local backup_dir = parent_dir .. "/.file_backups"                                -- 备份文件夹
    local file_name = vim.fn.expand("%:t")                                           -- 获取文件名
    local timestamp = os.date("%Y%m%d_%H%M%S")                                       -- 获取当前时间戳
    local backup_file = backup_dir .. "/" .. file_name .. "_" .. timestamp .. ".bak" -- 备份文件路径，含时间戳
    -- 创建备份目录（如果不存在）
    if vim.fn.isdirectory(backup_dir) == 0 then
      vim.fn.mkdir(backup_dir, "p")
    end
    -- 备份文件
    vim.fn.writefile(vim.fn.readfile(current_file), backup_file)
    print("Backup saved to: " .. backup_file)
  end
  -- 设置自动命令，在文件保存前执行备份
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py", -- 仅备份python文件
    callback = backup_file,
  })
end
