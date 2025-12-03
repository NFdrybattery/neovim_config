return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  vscode = false,
  ft = ".md",
  event = {
    "BufReadPre **/知识库/**/*.md",
    "BufNewFile **/知识库/**/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "知识库",
        path = "D:/30_Study/30_Obs/知识库",
      },
    },
	templates = {
		folder = "90_模板",
	},
	attachments = {
		img_folder = "91_附件/images",
	},
	ui = { enable = false },  -- 避免与"MeanderingProgrammer/render-markdown.nvim"冲突
	disable_frontmatter = true,  -- 禁用格式化功能
  },
  -- keys = {
  --   {
  --     "<leader>ot",
  --     mode = { "n", "v" },
  --     "<cmd>ObsidianTemplate<cr>",
  --     desc = "应用模板",
  --   },
  -- }
}

