return {
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'EdenEast/nightfox.nvim',
    },
    config = function()
      local name = require('nightfox.config').fox
      local spec = require('nightfox.spec').load(name)
      require('scrollbar').setup {
        handle = {
          color = spec.bg4,
        },
        marks = {
          Error = { color = spec.diag.error },
          Warn = { color = spec.diag.warn },
          Info = { color = spec.diag.info },
          Hint = { color = spec.diag.hint },
        },
        handlers = {
          gitsigns = true,
        },
      }
    end,
  },
}
