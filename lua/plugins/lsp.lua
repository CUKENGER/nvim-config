return {
	-- 1. Mason (менеджер внешних бинарников)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- 2. Автоустановка линтеров и форматтеров
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettierd",
				"eslint_d",
				"stylua",
			},
		},
	},

	-- 3. Mason LSP Config (автоустановка серверов языков)
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"jsonls",
				"harper_ls",
			},
			automatic_installation = true,
		},
	},

	-- 4. LSP Config (новый API Neovim 0.11+)
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Назначаем возможности автодополнения cmp для всех LSP серверов сразу
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- Индивидуальные настройки серверов через нативный API Neovim 0.11
			vim.lsp.config("cssls", {
				settings = {
					css = { validate = true, lint = { unknownProperties = "warning" } },
					scss = { validate = true },
				},
			})

			vim.lsp.config("emmet_ls", {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "scss" },
			})

			vim.lsp.config("jsonls", {
				init_options = { provideFormatter = true },
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			-- Активируем серверы
			local servers = {
				"lua_ls",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"jsonls",
				"harper_ls",
			}

			for _, server in ipairs(servers) do
				vim.lsp.enable(server)
			end
		end,
	},

	-- 5. TypeScript Tools
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
			settings = {
				separate_diagnostic_server = false,
				tsserver_max_memory = 2048,
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "literals",
				},
			},
		},
	},

	-- 6. Линтер nvim-lint (ESLint)
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
