return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Initialize with vim regex engine (avoids needing the spectre-oxi native module)
    require('spectre').setup {
      default = {
        replace = {
          cmd = 'sed',
        },
        exclude = {
          'node_modules/**',
          'dist/**',
          '.git/**',
          'target/**',
        },
      },
    }

    -- Add key mappings for common operations
    vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
      desc = 'Toggle Spectre',
    })
    vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
      desc = 'Search current word',
    })
    vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
      desc = 'Search current word',
    })
    vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = 'Search on current file',
    })
  end,
}
