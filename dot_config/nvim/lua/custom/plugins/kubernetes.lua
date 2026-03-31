-- lua/custom/plugins/kubernetes.lua
return {
  {
    'towolf/vim-helm',
    lazy = false,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function()
      -- Helm LS
      vim.lsp.config('helm_ls', {
        cmd = { 'helm_ls', 'serve' },
        filetypes = { 'helm' },
        root_markers = { 'Chart.yaml' },
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = 'yaml-language-server',
            },
          },
        },
      })
      vim.lsp.enable 'helm_ls'

      -- YAML LS with Kubernetes schema
      vim.lsp.config('yamlls', {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose' },
        root_markers = { '.git' },
        settings = {
          yaml = {
            schemas = {
              kubernetes = '*.k8s.{yml,yaml}',
              ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone-strict/all.json'] = {
                'k8s/**/*.{yml,yaml}',
                'kubernetes/**/*.{yml,yaml}',
                'deploy/**/*.{yml,yaml}',
              },
            },
            schemaStore = {
              enable = true,
            },
          },
        },
      })
      vim.lsp.enable 'yamlls'
    end,
  },
}
