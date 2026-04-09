return {
  'tveskag/nvim-blame-line',
  config = function()
    -- Add key mappings for common operations
    vim.keymap.set('n', '<leader>gb', '<cmd>:ToggleBlameLine<CR>', {
      desc = 'Toggle GitBlameLine',
    })
  end,
}
