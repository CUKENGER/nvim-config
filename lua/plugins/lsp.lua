return {
	-- Mason для управления инструментами
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"eslint_d",
					"prettierd",
					-- "stylua"
				}, -- Форматировщики
			})
		end,
	},
	--
	-- -- Mason-LSPConfig для автоматической установки LSP
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"emmet_ls",
					"cssls",
					"tailwindcss",
					"css_variables",
					"cssmodules_ls",
					"harper_ls",
					"jsonls",
					"lua_ls",
					"stylua",
				},
				automatic_installation = true,
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Настройка серверов
			vim.lsp.config("cssls", {
				capabilities = capabilities,
				settings = {
					css = { validate = true, lint = { unknownProperties = "warning" } },
					scss = { validate = true, lint = { unknownProperties = "warning" } },
					sass = { validate = true, lint = { unknownProperties = "warning" } },
					less = { validate = true },
				},
				filetypes = { "css", "scss", "sass", "less" },
				root_dir = function(fname)
					return vim.fs.root(0, { "package.json", ".git" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "cssls" })

			vim.lsp.config("tailwindcss", {
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
							elixir = "phoenix-heex",
							heex = "phoenix-heex",
						},
					},
				},
				filetypes = {
					"aspnetcorerazor",
					"astro",
					"astro-markdown",
					"blade",
					"clojure",
					"django-html",
					"htmldjango",
					"edge",
					"eelixir",
					"elixir",
					"ejs",
					"erb",
					"eruby",
					"gohtml",
					"gohtmltmpl",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"htmlangular",
					"html-eex",
					"heex",
					"jade",
					"leaf",
					"liquid",
					"markdown",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					"php",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"templ",
				},
				root_dir = function(fname)
					return vim.fs.root(0, { "package.json", ".git" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "tailwindcss" })

			vim.lsp.config("emmet_ls", {
				capabilities = capabilities,
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "scss" },
				root_dir = function(fname)
					return vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "emmet_ls" })

			vim.lsp.config("css_variables", {
				capabilities = capabilities,
				settings = {
					cssVariables = {
						lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
						blacklistFolders = {
							"**/.cache",
							"**/.DS_Store",
							"**/.git",
							"**/.hg",
							"**/.next",
							"**/.svn",
							"**/bower_components",
							"**/CVS",
							"**/dist",
							"**/node_modules",
							"**/tests",
							"**/tmp",
						},
					},
				},
				filetypes = { "css", "scss", "less" },
				root_dir = function(fname)
					return vim.fs.root(0, { "package.json", ".git" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "css_variables" })

			vim.lsp.config("cssmodules_ls", {
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_dir = function(fname)
					return vim.fs.root(0, { "package.json" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "cssmodules_ls" })

			vim.lsp.config("harper_ls", {
				capabilities = capabilities,
				filetypes = {
					"c",
					"cpp",
					"cs",
					"gitcommit",
					"go",
					"html",
					"java",
					"javascript",
					"lua",
					"markdown",
					"nix",
					"python",
					"ruby",
					"rust",
					"swift",
					"toml",
					"typescript",
					"typescriptreact",
					"haskell",
					"cmake",
					"typst",
					"php",
					"dart",
					"clojure",
					"sh",
				},
				root_dir = function(fname)
					return vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "harper_ls" })

			vim.lsp.config("jsonls", {
				capabilities = capabilities,
				filetypes = { "json", "jsonc" },
				init_options = { provideFormatter = true },
				root_dir = function(fname)
					return vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "jsonls" })

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				filetypes = { "lua" },
				root_dir = function(fname)
					return vim.fs.root(
						0,
						{
							".luarc.json",
							".luarc.jsonc",
							".luacheckrc",
							".stylua.toml",
							"stylua.toml",
							"selene.toml",
							"selene.yml",
							".git",
						}
					) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "lua_ls" })

			vim.lsp.config("stylua", {
				capabilities = capabilities,
				filetypes = { "lua" },
				root_dir = function(fname)
					return vim.fs.root(0, { ".stylua.toml", "stylua.toml", ".editorconfig" }) or vim.fn.getcwd()
				end,
			})
			vim.lsp.enable({ "stylua" })

			-- TypeScript через typescript-tools
			require("typescript-tools").setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					print("TypeScript Tools LSP attached")
					client.server_capabilities.documentFormattingProvider = false
				end,
				settings = {
					separate_diagnostic_server = false,
					tsserver_max_memory = 1024,
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "literals",
						includeInlayFunctionLikeReturnTypeHints = false,
					},
				},
			})
		end,
	},

	-- Tailwind Tools
	-- {
	-- 	"luckasRanarison/tailwind-tools.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	opts = {
	-- 		document_color = {
	-- 			enabled = false,
	-- 		},
	-- 	},
	-- },

	-- CSS Var Viewer
	-- {
	-- 	"farias-hecdin/CSSVarViewer",
	-- 	ft = "css",
	-- 	config = true,
	-- },

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
