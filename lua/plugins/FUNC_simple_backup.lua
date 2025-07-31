-- 文件保存备份插件
return {
  {
	-- dir = "D:/40_Code/40_lua/simple-backup.nvim",
    'NFdrybattery/simple-backup.nvim',
    event = "VeryLazy",
    config = function()
      require('simple_backup').setup({
        backup_dir = ".history",       -- 备份目录名
        include_files = {"*.py","*.c"},      -- 只备份python文件
      })
    end
  }
}

