return {
  -- Code outline window for skimming and quick navigation
  'stevearc/aerial.nvim',
  config = function()
    require('aerial').setup {
      log_level = 'info',
      backends = { 'treesitter', 'lsp' },
      highlight_on_hover = true,
      attach_mode = 'global',
      filter_kind = {
        'Class',
        'Field',
        'Variable',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
      },
    }

    -- Add key mappings for common operations
    vim.keymap.set('n', '<leader>a', ':AerialToggle<CR>', {
      desc = 'Open Aerial',
    })
  end,
}
