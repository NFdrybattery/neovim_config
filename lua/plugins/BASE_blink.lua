return {
  "saghen/blink.cmp",
  version = "*",
  vscode = false,
  lazy = true, 
  -- event = {"InsertEnter"},
  opts = {
    completion = { 
      accept = { auto_brackets = { enabled = false }, },
      list = { 
        selection = { preselect = true, auto_insert = false },
        max_items = 10,
      },
      menu = {
        auto_show = true,
        min_width = 30, 
        border = "single", 
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", gap = 1 , "source_name", gap = 1 }, 
          },
          components = {
            label = {
              ellipsis = true,
              width = { fill = true, max = 50 },
            }, 
          }, 
          -- treesitter = { 'lsp' }, 
        }, 
        -- direction_priority = { 's', 'n' },
      },
      documentation = { 
        auto_show = true,
        auto_show_delay_ms = 100, 
        treesitter_highlighting = false,
        window = {
          min_width = 50, 
          max_width = 80,
          border = "single",
          direction_priority = {
            menu_north = { 'e', 'n', 's' },
            menu_south = { 'e', 's', 'n' },
          },
        }, 
      }, 
      ghost_text = {
        show_with_menu = false
      }, 
    },
    sources = {
      default = { 'lsp', 'path', 'buffer', 'codeium' },
      providers = {
        codeium = { name = 'Codeium', module = 'codeium.blink', async = false, max_items =3,min_keyword_length = 1 },
      },
    },
    fuzzy = { 
      implementation = "prefer_rust_with_warning", 
      sorts = {
        'score',      -- Primary sort: by fuzzy matching score
        'sort_text',  -- Secondary sort: by sortText field if scores are equal
        'label',      -- Tertiary sort: by label if still tied
      }, 
    }, 
    keymap = { 
      preset = 'none', 
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<A-k>'] = { 'select_prev', 'fallback_to_mappings' },
      ['<A-j>'] = { 'select_next', 'fallback_to_mappings' },
      ['<A-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<A-n>'] = { 'scroll_documentation_down', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
    },
    signature = { enabled = false }, 
    cmdline = { 
      enabled = true,
      keymap = { preset = 'cmdline' },
      sources = { 'buffer', 'cmdline' },
    }, 
    appearance = {
      nerd_font_variant = 'normal', 
      kind_icons = {
        Codeium = "", 
        Copilot = "",
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',
        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',
        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',
        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨', 
        Keyword = '󰻾',
        Constant = '󰏿',
        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      }, 
    },
  }, 
}
