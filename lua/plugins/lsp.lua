return {
	-- Mason для управления инструментами
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"eslint",
					"prettierd",
					-- "stylua"
				}, -- Форматировщики
			})
		end,
	},

	-- Mason-LSPConfig для автоматической установки LSP
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				-- ensure_installed = { "lua_ls", "rust_analyzer", "tailwindcss", "emmet_ls", "ts_ls" },
				ensure_installed = {
					-- "lua_ls",
					-- "rust_analyzer",
					-- "tailwindcss",
					"emmet_ls",
				},
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
			-- lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			-- 	cssmodules = {
			-- 		cmd = { "cssmodules-language-server" },
			-- 		filetypes = {
			-- 			"css",
			-- 			"scss",
			-- 			"sass",
			-- 			"javascript",
			-- 			"javascriptreact",
			-- 			"typescript",
			-- 			"typescriptreact",
			-- 		},
			-- 		root_dir = lspconfig.util.root_pattern("package.json", ".git"),
			-- 		init_options = { camelCase = true },
			-- 	},
			-- })

			-- lspconfig.cssmodules.setup({
			--   capabilities = capabilities,
			-- })

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

			-- lspconfig.ts_ls.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "jsx", "tsx" },
			-- 	on_attach = function(client, bufnr)
			-- 		print("TypeScript LSP attached")
			-- 		client.server_capabilities.documentFormattingProvider = false
			-- 	end,
			-- })

			require("typescript-tools").setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(client, bufnr)
					print("TypeScript Tools LSP attached")
					client.server_capabilities.documentFormattingProvider = false
				end,
				settings = {
					-- Настройки для TypeScript
					separate_diagnostic_server = false,
					tsserver_max_memory = 1024, -- Ограничение памяти до 1 ГБ
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "literals", -- Менее ресурсоемко, чем "all"
						includeInlayFunctionLikeReturnTypeHints = false, -- Отключаем для скорости
					},
					-- tsserver_file_preferences = {
					-- 	includeInlayParameterNameHints = "all",
					-- 	includeInlayFunctionLikeReturnTypeHints = true,
					-- },
				},
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

			lspconfig.eslint_d.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					format = true,
					codeAction = {
						disableRuleComment = { enable = true, location = "separateLine" },
						showDocumentation = { enable = true },
					},
				},
			})

			-- lspconfig.lua_ls.setup({ capabilities = capabilities })
			-- lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.emmet_ls.setup({ capabilities = capabilities })
		end,
	},

	-- Tailwind Tools
	{
		"luckasRanarison/tailwind-tools.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		opts = {
			document_color = {
				-- enabled = true,
				enabled = false,
				-- kind = "inline", -- Легче, чем "foreground"
			},
		},
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
				ensure_installed = { "javascript", "typescript", "tsx", "css", "scss", "html", "lua" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false, -- Ускоряет работу
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				autotag = { enable = true },
				incremental_selection = { enable = false }, -- Отключаем, если не используете
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

	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Emmet
	-- {
	-- 	"olrtg/nvim-emmet",
	-- },

	-- Форматирование (через Mason)
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	opts = {
	-- 		ensure_installed = { "eslint", "prettierd", "stylua" }, -- Исправлено "eslint-lsp" на "eslint"
	-- 	},
	-- },
}
