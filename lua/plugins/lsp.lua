return {
  -- Mason для управления инструментами
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig для автоматической установки LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "emmet_ls", "ts_ls" },
      })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Кастомный сервер для cssmodules
      lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        cssmodules = {
          cmd = { "cssmodules-language-server" },
          filetypes = {
            "css",
            "scss",
            "sass",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
          root_dir = lspconfig.util.root_pattern("package.json", ".git"),
          init_options = { camelCase = true },
        },
      })

      lspconfig.cssmodules.setup({
        capabilities = capabilities,
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          css = { validate = true, lint = { unknownProperties = "warning" } },
          scss = { validate = true, lint = { unknownProperties = "warning" } },
          sass = { validate = true, lint = { unknownProperties = "warning" } },
          less = { validate = true },
        },
        filetypes = { "css", "scss", "sass", "less" }, -- Убрали "cssmodules", так как он отдельно
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "jsx", "tsx" },
        on_attach = function(client, bufnr)
          print("TypeScript LSP attached")
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        settings = {
          tailwindCSS = {
            validate = true,
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidScreen = "error",
              invalidVariant = "error",
              invalidConfigPath = "error",
              invalidTailwindDirective = "error",
              recommendedVariantOrder = "warning",
            },
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            includeLanguages = {
              eelixir = "html-eex",
              eruby = "erb",
              templ = "html",
              htmlangular = "html",
            },
          },
        },
      })

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.emmet_ls.setup({ capabilities = capabilities })
    end,
  },

  -- Tailwind Tools
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- CSS Var Viewer
  {
    "farias-hecdin/CSSVarViewer",
    ft = "css",
    config = true,
  },

  -- Tree-sitter (необходим для autotag и tailwind-tools)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript", "tsx", "css", "scss" },
        highlight = { enable = true },
        autotag = { enable = true },
      })
    end,
  },

  -- Автозакрытие тегов
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx" },
      })
    end,
  },

  -- TypeScript Tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- Emmet
  {
    "olrtg/nvim-emmet",
  },

  -- Форматирование (через Mason)
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "eslint", "prettierd", "stylua" }, -- Исправлено "eslint-lsp" на "eslint"
    },
  },
}
