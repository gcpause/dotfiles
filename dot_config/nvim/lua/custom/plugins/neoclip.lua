return {
  'AckslD/nvim-neoclip.lua',
  dependencies = 'nvim-telescope/telescope.nvim',
  config = function()
    require('neoclip').setup {
      default_register = '+',
    }
    require('telescope').load_extension 'neoclip'
    -- Add key mappings for common operations
    vim.keymap.set('n', '<leader>sy', ':Telescope neoclip a<CR>', {
      desc = 'Search and select recent yanks',
    })
  end,
}
