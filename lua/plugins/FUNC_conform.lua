
return {
  {
    "stevearc/conform.nvim",
	-- version = "*",
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
          print("pyproject_path not found!")
        end
      end
      
      return {
        formatters_by_ft = {
          python = { "yapf" },
          markdown = {
            "markdownlint-cli2",
            extra_args = function()
              -- 返回动态生成的 CLI 参数
              return {
                "--config",
                -- 内联 JSON 配置（无需物理文件）
                [[{
                  "config": {
                    "MD001": false,  -- 禁用一级标题必须第一个出现的规则
                    "MD041": false,  -- 禁用文件必须以一级标题开头的规则
                    "no-inline-html": false
                  },
                  "frontMatter": {               -- 关键配置：跳过 Front Matter
                    "type": "yaml",              -- 识别 YAML 块
                    "start": "---",             -- 起始标记
                    "end": "---",               -- 结束标记
                    "skip": true                 -- 完全跳过检查
                  }
                  }]],
                "--fix"
              }
            end,
          },
        },
        formatters = {
          yapf = {
            command = "yapf",
            args = pyproject_path and { "--style=" .. pyproject_path },
            stdin = true,
            timeout_ms = 8000,
          },
		  -- markdownlint-cli2 = {
            -- command = "markdownlint-cli2",
            -- args = { "$FILENAME" },
            -- stdin = false,
          -- }
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
