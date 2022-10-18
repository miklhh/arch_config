local cmp = require'cmp'
local lspkind = require('lspkind')

-- Completion engine setup.
cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    --formatting = {
    --  format = lspkind.cmp_format({
    --    mode = 'symbol',
    --    with_text = true,
    --    maxwidth = 70,
    --    menu = ({
    --      buffer = "[Buffer]",      
    --      nvim_lsp = "[LSP]",       
    --      luasnip = "[LuaSnip]",    
    --      nvim_lua = "[Lua]",       
    --      latex_symbols = "[LaTeX]",
    --    }),
    --  }),
    --},
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = 0,
        side_padding = 0,
      },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. strings[1] .. " "
          kind.menu = "    (" .. strings[2] .. ")"

          return kind
        end,
  },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- NVim LSP autocompletions
        { name = 'vsnip' },     -- VSnip autocompletions
        { name = 'path' },      -- cmp-path autocompletions
        --{ name = 'buffer' },    -- cmp-buffer autocompletions
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

