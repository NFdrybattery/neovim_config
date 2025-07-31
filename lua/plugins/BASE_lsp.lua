return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = "LazyFile",
  vscode = false,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          width = 60,  -- 限制诊断文本宽度
          wrap = true, -- 自动换行
          prefix = "■",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      --flags = {
      --debounce_text_changes = 1000, -- 设置文本更改的防抖时间为 1000 毫秒
      --},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      --@type lspconfig.options
      servers = {
        -- pyright启用代码跳转、补全、类型检查功能
        -- pyright = {
        --   settings = {
        --     python = {
        --       analysis = {
        --         typeCheckingMode = "off",               -- 关闭类型检查（关键性能优化）
        --         diagnosticMode = "openFilesOnly",       -- 仅分析打开的文件
        --         disableBackgroundAnalysis = true,       -- 完全关闭后台分析
        --         disableOrganizeImports = true,          -- 禁用自动导入整理
        --         autoSearchPaths = false,                -- 自动搜索路径
        --         diagnosticSeverityOverrides = {
        --           reportUnusedImport = "information",   -- 未使用的导入
        --           reportMissingImports = "error",       -- 缺失的导入
        --           reportUnusedVariable = "information"  -- 未使用的变量
        --         }, 
        --         exclude = {
        --           "**/.venv/**", 
        --           "**/__pycache__/**", 
        --           "**/.history/**", 
        --           "**/.file_backups/**", 
        --         },                                      -- 忽略非项目目录
        --         incremental = true,                     -- 启用增量分析
        --         useLibraryCodeForTypes = false,         -- 
        --         pythonPath = vim.fn.getcwd().."/.venv/Scripts/python.exe",  -- 显式指定Python路径
        --       },
        --     },
        --   }, 
        --   -- textDocumentSync = {
        --   --   change = 2,  -- 2 表示增量同步（Incremental）
        --   --   openClose = true,
        --   --   save = { includeText = false },
        --   -- },
        --   flags = {
        --     debounce_text_changes = 300                -- 防抖延迟（毫秒）
        --   }, 
        -- }, 
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                ruff = { enabled = false },
                jedi = { 
                  enabled = true,
                  --environment = vim.fn.getcwd().."/.venv/Scripts/python.exe", -- 虚拟环境路径
                  --extra_paths = { vim.fn.getcwd().."/.venv/Lib/site-packages"}, 
                },
                pylsp_yapf = { enabled = false },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                pylint = { enabled = false },
                pyflakes = { enabled = false },
                autopep8 = { enabled = false },
                black = { enabled = false },
                rope = { enabled = false },
                preload = { enabled = false },
                pylsp_mypy = { enabled = false }
              },
            },
          },
        },
        -- ruff启用静态分析、代码修复功能，代码分析配置项在pyproject.toml定义
        ruff = {
          init_options = {
            settings = {
              lint = { enable = true},  -- 静态分析（默认启用）
              format = { enable = false},
              organizeImports = true,         -- 禁用自动整理导入
              fixAll = false,                  -- 自动修复所有问题
              hover = { enable = false },                   -- 禁用悬浮提示（需手动开启）
              codeAction = { enable = false }, -- 代码操作（如快速修复）
              definition = { enable = false }, -- 必须启用定义跳转
              references = { enable = false }, -- 启用引用查找（可选）
            },
          },
          -- handlers = {
          --   ["textDocument/definition"] = function() return nil end,
          --   ["textDocument/references"] = function() return nil end, 
          --   ["textDocument/hover"] = function() return nil end,
          -- }, 
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      --@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    }
    return ret
  end,
  ---@param opts PluginLspOpts
  config = function(_, opts)
    -- setup autoformat
    LazyVim.format.register(LazyVim.lsp.formatter())

    -- setup keymaps
    LazyVim.lsp.on_attach(function(client, buffer)
      require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    LazyVim.lsp.setup()
    LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

    -- diagnostics signs
    if vim.fn.has("nvim-0.10.0") == 0 then
      if type(opts.diagnostics.signs) ~= "boolean" then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
          name = "DiagnosticSign" .. name
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end
      end
    end

    if vim.fn.has("nvim-0.10") == 1 then
      -- inlay hints
      if opts.inlay_hints.enabled then
        LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
          if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end)
      end
    end

    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = LazyVim.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local servers = opts.servers
    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local has_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {},
      has_blink and blink.get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    local function setup(server)
      local server_opts = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
      }, servers[server] or {})
      if server_opts.enabled == false then
        return
      end

      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end

    -- get all the servers that are available through mason-lspconfig
    local have_mason, mlsp = pcall(require, "mason-lspconfig")
    local all_mslp_servers = {}
    if have_mason then
      all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    end

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
      if server_opts then
        server_opts = server_opts == true and {} or server_opts
        if server_opts.enabled ~= false then
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
    end

    if have_mason then
      mlsp.setup({
        ensure_installed = vim.tbl_deep_extend(
          "force",
          ensure_installed,
          LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
        ),
        handlers = { setup },
      })
    end

    if LazyVim.lsp.is_enabled("denols") and LazyVim.lsp.is_enabled("vtsls") then
      local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
      LazyVim.lsp.disable("vtsls", is_deno)
      LazyVim.lsp.disable("denols", function(root_dir, config)
        if not is_deno(root_dir) then
          config.settings.deno.enable = false
        end
        return false
      end)
    end
  end,
}
