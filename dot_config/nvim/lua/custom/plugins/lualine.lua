return {
   {
      "nvim-lualine/lualine.nvim",
      config = function()
         require("lualine").setup({
            options = {
               theme = "tokyonight",
            },
            sections = {
               lualine_c = { {
                  "filename",
                  path = 1,
               } },
               lualine_x = { "location" },
               lualine_y = { "encoding", "%{&spelllang}" },
               lualine_z = { "filetype" },
            },
         })
      end,
   },
}

