return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = { 'java' },
    config = function()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local project_hash = string.sub(vim.api.nvim_call_function('sha256', { vim.fn.getcwd() }), 1, 6)
      local data_path = vim.env.HOME .. '/.cache/jdtls/' .. project_name .. '-' .. project_hash

      local on_attach = function(_, bufnr)
        --        require('custom.aixigo-dap').setup()
        require('jdtls').setup_dap()
        local opts = { noremap = true, silent = true }
        -- See https://github.com/mfussenegger/nvim-jdtls/blob/master/doc/jdtls.txt for available LSP extensions for jdtls
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>oi', ":lua require('jdtls').organize_imports()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ev', ":lua require('jdtls').extract_variable()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ev', ":lua require('jdtls').extract_variable(true)<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ec', ":lua require('jdtls').extract_constant()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ec', ":lua require('jdtls').extract_constant(true)<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>em', ":lua require('jdtls').extract_method()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tf', ":lua require('jdtls').test_class()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tm', ":lua require('jdtls').test_nearest_method()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', ":lua require('jdtls').pick_test()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tg', ":lua require('jdtls.tests').generate()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ts', ":lua require('jdtls.tests').goto_subjects()<CR>", opts)
      end

      local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw' })

      local config = {
        root_dir = root_dir,
        on_attach = on_attach,
        cmd = {
          'jdtls',
          '-configuration',
          vim.env.HOME .. '/.cache/jdtls/configuration',
          '-data',
          data_path,
          '--jvm-arg=-javaagent:' .. vim.env.HOME .. '/.software/lombok.jar',
        },
        cmd_env = {
          JAVA_HOME = '/usr/lib/jvm/temurin-21-jdk-amd64/',
        },
        init_options = {
          bundles = vim.split(vim.fn.glob(vim.env.MASON .. '/share/java-*/*.jar'), '\n'),
          extendedClientCapabilities = {
            progressReportProvider = false,
          },
        },
        settings = {
          java = {
            completion = {
              importOrder = { 'com', 'feign', 'io', 'java', 'javax', 'liquibase', 'lombok', 'nl', 'org', 'picocli', 'rx' },
            },
            configuration = {
              maven = {
                userSettings = root_dir .. '/.mvn/settings.xml',
                globalSettings = root_dir .. '/.mvn/settings.xml',
              },
              -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
              -- And search for `interface RuntimeOption`
              -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
              runtimes = {
                {
                  name = 'JavaSE-1.8',
                  path = '/usr/lib/jvm/temurin-8-jdk-amd64/',
                },
                {
                  name = 'JavaSE-11',
                  path = '/usr/lib/jvm/temurin-11-jdk-amd64/',
                },
                {
                  name = 'JavaSE-17',
                  path = '/usr/lib/jvm/temurin-17-jdk-amd64/',
                },
                {
                  name = 'JavaSE-21',
                  path = '/usr/lib/jvm/temurin-21-jdk-amd64/',
                },
              },
            },
          },
          -- If we need GoogleStyle, this is already handled by conform.nvim, so we can use aixigo-style here as default
          ['java.format.settings.url'] = vim.env.HOME .. '/.config/java/eclipse-java-aixigo-style.xml',
          ['java.format.settings.profile'] = 'aixigo Stax Code Formatter',
        },
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function() require('jdtls').start_or_attach(config) end,
      })
    end,
  },
}
