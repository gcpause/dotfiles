return {
  {
    'ThePrimeagen/99',
    config = function()
      local _99 = require '99'

      _99.setup {
        -- When setting this to something that is not inside the CWD tools
        -- such as claude code or opencode will have permission issues
        -- and generation will fail refer to tool documentation to resolve
        -- https://opencode.ai/docs/permissions/#external-directories
        -- https://code.claude.com/docs/en/permissions#read-and-edit
        tmp_dir = './99-tmp',

        model = 'anthropic/claude-sonnet-4-6',

        --- Completions: #rules and @files in the prompt buffer
        completion = {
          --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
          source = 'blink', -- "native" (default), "cmp", or "blink"
        },

        md_files = {
          'AGENT.md',
        },
      }

      -- take extra note that i have visual selection only in v mode
      -- technically whatever your last visual selection is, will be used
      -- so i have this set to visual mode so i dont screw up and use an
      -- old visual selection
      --
      -- likely ill add a mode check and assert on required visual mode
      -- so just prepare for it now
      vim.keymap.set('v', '<leader><leader>v', function() _99.visual() end)

      --- if you have a request you dont want to make any changes, just cancel it
      vim.keymap.set('n', '<leader><leader>x', function() _99.stop_all_requests() end)

      vim.keymap.set('n', '<leader><leader>s', function() _99.search() end)
    end,
  },
}
