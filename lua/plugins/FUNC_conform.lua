-- 自动获取pyproject.toml文件位置
return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    vscode = false,
    opts = function()
      -- 查找 .venv 目录
      local venv_dir = vim.fn.finddir(".venv", ".;")
      local pyproject_path = nil
      
      if venv_dir ~= "" then
        -- 获取项目根目录（.venv 的父目录）
        local project_root = vim.fn.fnamemodify(venv_dir, ":h")
        pyproject_path = project_root .. "/pyproject.toml"
        
        -- 检查 pyproject.toml 是否存在
        if vim.fn.filereadable(pyproject_path) == 0 then
          pyproject_path = nil
        end
      end
      
      return {
        formatters_by_ft = {
          python = { "yapf" },
        },
        formatters = {
          yapf = {
		    command = "yapf",
            args = pyproject_path and { "--style=" .. pyproject_path } or {},
            stdin = true,
			timeout_ms = 8000,
          },
        },
      }
    end,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format()
        end,
        desc = "格式化代码",
      },
    },
  },
}
