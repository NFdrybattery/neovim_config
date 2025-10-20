-- codecompanion插件
return {
  "olimorris/codecompanion.nvim",
  version = "*",
  lazy = true,
  vscode = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
  keys = {
    { "<Leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat",  mode = { "n" }, noremap = true, silent = true },
    { "<Leader>an", "<cmd>CodeCompanionChat<cr>",        desc = "New Chat",     mode = { "n" }, noremap = true, silent = true },
    { "<Leader>ah", "<cmd>CodeCompanionHistory<cr>",     desc = "Chat History", mode = { "n" }, noremap = true, silent = true },
    { "<Leader>aA", "<cmd>CodeCompanionActions<cr>",     desc = "Code Actions", mode = { "n" }, noremap = true, silent = true },
  },
  config = function()
    require("codecompanion").setup({
      -- 全局选项
      opts = {
        language = "Chinese", -- 设置默认语言为中文
        send_code = false,    -- 是否发送代码上下文（根据需求调整）
        system_prompt = function(opts)
          return "你是一个智能编程助手，请用中文回答以下问题，保持简洁、准确、专业，对代码函数用法的问题给出简单的示范用法。"
        end,
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = os.getenv("DEEPSEEK_API_KEY"),
            },
          })
        end,
        -- glm = function()
        --   return{
        --     name = "glm",
        --     url  = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
        --     env  = { api_key = os.getenv("GLM_API_KEY") },
        --     headers = {
        --       ["Authorization"] = "Bearer ${api_key}",
        --       ["Content-Type"]  = "application/json",
        --     },
        --     roles = {
        --       llm =  "GLM",
        --       user = "用户",
        --     },
        --     opts = { stream = true, tools = false },
        --     handlers = {
        --       setup = function(self) return true end,
        --       form_messages = function(self, msgs) return { messages = msgs } end,
        --       chat_output = function(self, data) return { status="success", output=data } end,
        --     },
        --     schema = {
        --       model = { default = "glm-4.5-flash" },
        --       temperature = { type="number", default=0.7 },
        --     },
        --     features = {
        --       tool_code = false,
        --       tool_resources = false,
        --       auto_tool_name = false,
        --     },
        --   }
        -- end
      }, 
      -- 策略配置
      strategies = {
        chat = {
          adapter = {
            name = "deepseek",
            model = 'deepseek-chat',
            max_tokens = 1024,
            temperature = 0.7, -- 可选：控制生成结果的随机性
          },
          -- adapter = {
          --   name = "glm",
          --   model = 'glm-4.5-flash',
          --   max_tokens = 1024,
          --   temperature = 0.7, -- 可选：控制生成结果的随机性
          -- },
          roles = {
            llm = "󱢴 | DeepSeek",
            -- llm = " | GLM-4.5",
            user = "󰠗 |",
          },
          auto_scroll = true,
          opts = {
            completion_provider = "blink", -- blink|cmp|coc|default
          },
        },
        inline = {
          adapter = {
            name = "deepseek",
            model = "deepseek-chat",
            -- name = "glm",
            -- model = "glm-4.5-flash",
          }
        },
        agent = {
          adapter = {
            name = "deepseek",
            model = "deepseek-chat",
            -- name = "glm",
            -- model = "glm-4.5-flash",
          }
        },
      },
      -- 界面显示配置
      display = {
        chat = {
          icons = {
            pinned_buffer = " ", -- 固定缓冲区的图标
            watched_buffer = "👀 ", -- 监视缓冲区的图标
          },
          window = {
            layout = "vertical",      -- 布局方式：vertical|horizontal|float|buffer
            position = "left",        -- 位置：left|right|top|bottom
            border = "rounded",       -- 边框样式：single|double|rounded|solid|shadow|none
            height = 0.9,             -- 窗口高度（比例）
            width = 0.25,             -- 窗口宽度（比例）
            -- 高级位置微调（可选）
            row = 1,                  -- 垂直偏移（从顶部开始的行数）
            col = 200,                -- 水平偏移（从左侧开始的列数）
            relative = "editor",      -- 相对位置（editor|win）
            full_height = true,       -- 是否全高
            style = "minimal",        -- 隐藏行号等（minimal|default）
            title = "Code Companion", -- 窗口标题
            title_pos = "center",     -- 标题位置：left|center|right
            reuse = true,             -- 如果插件支持
            unique = true,            -- 确保唯一窗口
            opts = {                  -- 窗口本地选项
              wrap = true,            -- 自动换行
              spell = false,          -- 禁用拼写检查
              -- 其他选项...
            },
          },
          show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          separator = "─", -- The separator between the different messages in the chat buffer
          show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
          show_settings = false, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 30,
            -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
            picker = "telescope",
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to active chat's adapter)
              adapter = "deepseek",           -- e.g "copilot"
              -- adapter = "glm",
              ---Model for generating titles (defaults to active chat's model)
              model = "deepseek-chat",        -- e.g "gpt-4o"
              -- model = "glm",
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 10,   -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 1,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
          },
        },
      },
    })
  end,
}
