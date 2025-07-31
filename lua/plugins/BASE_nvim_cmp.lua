return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  vscode = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    -- "hrsh7th/cmp-buffer",
    --"hrsh7th/cmp-path",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local auto_select = true
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<A-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<A-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        --["<tab>"] = cmp.mapping.complete(),
        ["<tab>"] = LazyVim.cmp.confirm({ select = auto_select }),
        ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
        ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        -- { name = "copilot", priority = 100 },
        { name = "fittencode", priority = 99},
        -- { name = "buffer", priority = 80},
        { name = "nvim_lsp", priority = 90},
      }),
      window = {
        completion = cmp.config.window.bordered({border = 'single',}),
        documentation = cmp.config.window.bordered({border = 'solid',}),
      },
      formatting = {
        format = function(entry, item)
          local icons = LazyVim.config.icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end

          return item
        end,
      },
      experimental = {
        -- only show ghost text when we show ai completions
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText",
        } or false,
      },
      sorting = {
        comparators = {
          cmp.config.compare.exact,    -- 精确匹配优先
          cmp.config.compare.locality, -- 按距离排序
          cmp.config.compare.priority, -- 按优先级排序
          --cmp.config.compare.sort_text, -- lsp排序
          --cmp.config.compare.score,    -- 按匹配分数排序
          --cmp.config.compare.kind,     -- 按补全项类型排序
          --cmp.config.compare.length,   -- 按补全项长度排序
        },
      },
    }
  end,
}
