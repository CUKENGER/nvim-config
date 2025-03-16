return {
	{
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
	},
{
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", 'emmet_ls', 'ts_ls' },
      })
    end,
  },
-- 	{
--   "luckasRanarison/tailwind-tools.nvim",
--   name = "tailwind-tools",
--   build = ":UpdateRemotePlugins",
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "nvim-telescope/telescope.nvim", -- optional
--     "neovim/nvim-lspconfig", -- optional
--   },
-- opts = {
--       -- Отключите функции, связанные с цветами, если они не нужны
--       lspconfig = {
--         color_support = false, -- Отключите поддержку цветов
--       },
--     },
-- },
{
    'farias-hecdin/CSSVarViewer',
    ft = "css",
    config = true,
    -- If you want to configure some options, replace the previous line with:
    -- config = function()
    -- end,
},
{'windwp/nvim-ts-autotag'},
{
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
},
{
  "olrtg/nvim-emmet",
},
}
