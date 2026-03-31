return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'onsails/lspkind.nvim',
      'saadparwaiz1/cmp_luasnip',
    },

    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer', keyword_length = 4 },
        },
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        formatting = {
          format = require('lspkind').cmp_format {
            mode = 'symbol_text',
            menu = {
              buffer = '[buf]',
              nvim_lsp = '[LSP]',
            },
          },
        },
      }
    end,
  },
}
