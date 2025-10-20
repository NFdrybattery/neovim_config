return {
  "neovim/nvim-lspconfig",
  -- version = "*",
  lazy = true,
  event = "LazyFile",
  dependencies = {
    "mason-org/mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = function()
    ---@class PluginLspOpts
    local ret = {
      -- 诊断配置
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "■",
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
      
      -- 内联提示
      inlay_hints = {
        enabled = true,
        exclude = { "vue" },
      },
      
      -- 代码镜头
      codelens = {
        enabled = false,
      },
      
      -- 全局能力
      capabilities = {
        workspace = {
          workspaceFolders = true, 
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
        textDocument = {
          positionEncoding = { "utf-16" }  -- 明确指定 UTF-8 优先
        }, 
      },
      -- debounce_text_changes = 100,
      -- 格式化选项
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                jedi = { enabled = true },
                ruff = { enabled = false },
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
        ruff = {
          settings = {
            lint = { enable = true },
            format = { enable = false },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
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
  config = vim.schedule_wrap(function(_, opts)
    -- setup autoformat
    LazyVim.format.register(LazyVim.lsp.formatter())

    -- setup keymaps
    LazyVim.lsp.on_attach(function(client, buffer)
      require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
    end)

    LazyVim.lsp.setup()
    LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

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

    -- folds
    -- if opts.folds.enabled then
    --   LazyVim.lsp.on_supports_method("textDocument/foldingRange", function(client, buffer)
    --     if LazyVim.set_default("foldmethod", "expr") then
    --       LazyVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
    --     end
    --   end)
    -- end

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

    -- diagnostics
    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = function(diagnostic)
        local icons = LazyVim.config.icons.diagnostics
        for d, icon in pairs(icons) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
        return "●"
      end
    end
    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    if opts.capabilities then
      vim.lsp.config("*", { capabilities = opts.capabilities })
    end

    -- get all the servers that are available through mason-lspconfig
    local have_mason = LazyVim.has("mason-lspconfig.nvim")
    local mason_all = have_mason
        and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
      or {} --[[ @as string[] ]]
    local mason_exclude = {} ---@type string[]

    ---@return boolean? exclude automatic setup
    local function configure(server)
      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as lazyvim.lsp.Config]]

      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server
        return
      end

      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      local setup = opts.setup[server] or opts.setup["*"]
      if setup and setup(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        vim.lsp.config(server, sopts) -- configure the server
        if not use_mason then
          vim.lsp.enable(server)
        end
      end
      return use_mason
    end

    local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
    if have_mason then
      require("mason-lspconfig").setup({
        ensure_installed = vim.list_extend(install, LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}),
        automatic_enable = { exclude = mason_exclude },
      })
    end
  end),
}
