-- Copilot_Chat折叠
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    vscode = false,
    event = "VeryLazy", -- 延迟加载
    opts= {
      -- 核心禁用设置
      context = "none", 
      selection = function(source)
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local start_line = math.max(1, cursor_pos[1] - 5)  -- 向上取5行
        local end_line = math.min(vim.api.nvim_buf_line_count(0), cursor_pos[1] + 5)  -- 向下取5行
        -- 返回格式化后的代码块（确保为字符串）
        local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        return "```" .. vim.bo.filetype .. "\n" .. table.concat(lines, "\n") .. "\n```"
      end,
      model = "gpt-4.1",
      question_header = " 󱜸 [YOU ]", -- Header to use for user questions
      answer_header = " 󱢴 [AI ]", -- Header to use for AI answers
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.2, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.9, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'win', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = 1, -- row position of the window, default is centered
        col = 500, -- column position of the window, default is centered
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      },
      highlight_selection = false, -- Highlight selection
      highlight_headers = true,
      chat_autocomplete = false,
      auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
      language = "zh", 
    }, 
    keys = {
      { "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "问答" },
    }, 
  },
}