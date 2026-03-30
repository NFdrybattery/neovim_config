-- codecompanion插件
return {
  "olimorris/codecompanion.nvim",
  version = "19.5.0",
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
    { "<Leader>ac", "<cmd>CodeCompanionCLI<cr>", desc = "Toggle Chat",  mode = { "n" }, noremap = true, silent = true },
    { "<Leader>aA", "<cmd>CodeCompanionActions<cr>",     desc = "Code Actions", mode = { "n" }, noremap = true, silent = true },
  },
  config = function()
    require("codecompanion").setup({
      -- 全局选项
      opts = {
        language = "Chinese", -- 设置默认语言为中文
        send_code = false,    -- 是否发送代码上下文（根据需求调整）
      },
      adapters = {
        http = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = os.getenv("DEEPSEEK_API_KEY"),
              },
            })
          end,
          glm = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url  = "https://open.bigmodel.cn/api/paas/v4",
                api_key = os.getenv("GLM_API_KEY"), 
                chat_url = "/chat/completions", 
              },
              schema = {
                model = { default = "glm-4.7-flash" },
              },
            })
          end,
          qwen = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://dashscope.aliyuncs.com/compatible-mode/v1",
                api_key = os.getenv("QWEN_API_KEY"), 
                chat_url = "/chat/completions", 
              },
              schema = {
                model = { default = "qwen3.5-flash" },
              },
            })
          end,
        },
      }, 
      -- 策略配置
      interactions = {
        chat = {
          adapter = "qwen",
          roles = {
            llm = function(adapter)
              return "󱢴 | " .. adapter.formatted_name
            end,
            user = "󰠗 | User",
          },
          opts = {
            completion_provider = "blink", -- blink|cmp|coc|default
          },
        },
        inline = {
          adapter = "qwen"
        },
        agent = {
          adapter = "qwen"
        },
        cli = {
          agent = "qwen", 
          agents = {
            qwen = {
              cmd = "qwen", 
              args = {},
              description = "Qwen CLI",
              provider = "buffer",
            }, 
          }, 
        }, 
      },
      rules = {
        default = {
          description = "My default group",
          files = {
            "~/.rules/codecompanion.md",
          },
        },
        opts = {
          chat = {
            autoload = "default",
            enabled = true, 
          },
        },
      }, 
      -- 界面显示配置
      display = {
        chat = {
          icons = {
            pinned_buffer = " ", -- 固定缓冲区的图标
            watched_buffer = "👀 ", -- 监视缓冲区的图标
            chat_context = "📎️",
          },
          fold_context = true,
          window = {
            layout = "vertical",      -- 布局方式：vertical|horizontal|float|buffer
            position = "left",        -- 位置：left|right|top|bottom
            border = "rounded",       -- 边框样式：single|double|rounded|solid|shadow|none
            height = 0.9,             -- 窗口高度（比例）
            width = 0.3,             -- 窗口宽度（比例）
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
          show_header_separator = true,
          show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        },
        cli = {
          window = {
            layout = "vertical",
            width = 0.3,
            height = 0.6,
            opts = {
              list = false,
            },
           }, 
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
              adapter = "glm",
              ---Model for generating titles (defaults to active chat's model)
              model = "glm-4.7-flash",
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
