return {
  "theHamsta/nvim-dap-virtual-text",
  lazy = true,
  vscode = false,
  event = {"BufReadPre", "BufNewFile"}, 
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- 配置 nvim-dap-virtual-text
    require("nvim-dap-virtual-text").setup({
      enabled = false,
    })
    -- 添加动态切换命令
    vim.api.nvim_create_user_command("ToggleVirtualText", function()
      local virtual_text = require("nvim-dap-virtual-text")
      virtual_text.toggle()
    end, {})
    -- 添加快捷键
    vim.api.nvim_set_keymap("n", "<leader>uv", ":ToggleVirtualText<CR>", { noremap = true, silent = true })
  end,
}