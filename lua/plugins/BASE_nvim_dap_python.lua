return {
  "mfussenegger/nvim-dap-python",
  -- stylua: ignore
  lazy = true, 
  config = function()
    require("dap-python").setup("uv")
    -- require("dap-python").setup("debugpy-adapter")
  end,
}
