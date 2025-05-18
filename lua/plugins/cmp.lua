return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"windwp/nvim-autopairs",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Только явный выбор
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", max_item_count = 10 },
					{ name = "vsnip",    max_item_count = 5 },
				}, {
					{ name = "buffer", max_item_count = 5, option = { keyword_length = 3 } },
					{ name = "path",   max_item_count = 5 },
				}),
				performance = {
					debounce = 150,
					throttle = 100,
					fetching_timeout = 200,
				},
			})

			-- Командная строка
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer", max_item_count = 5 } },
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path", max_item_count = 5 },
				}, {
					{ name = "cmdline", max_item_count = 5 },
				}),
			})
		end,
	},
}

-- return {
-- 	{ 'neovim/nvim-lspconfig' },
-- 	{ 'hrsh7th/cmp-nvim-lsp' },
-- 	{ 'hrsh7th/cmp-buffer' },
-- 	{ 'hrsh7th/cmp-path' },
--
-- 	{ 'hrsh7th/cmp-cmdline' },
-- 	{ 'hrsh7th/nvim-cmp' },
--
-- 	-- Для vsnip пользователей
-- 	{ 'hrsh7th/cmp-vsnip' },
-- 	{ 'hrsh7th/vim-vsnip' },
--
-- 	-- Настройка nvim-cmp
-- 	{
-- 		'hrsh7th/nvim-cmp',
-- 		dependencies = {
-- 			"windwp/nvim-autopairs",
-- 			opts = {},
-- 		},
-- 		config = function()
-- 			local cmp = require 'cmp'
--
-- 			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- 			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
-- 			cmp.setup({
-- 				snippet = {
-- 					expand = function(args)
-- 						vim.fn["vsnip#anonymous"](args.body) -- Для пользователей vsnip
-- 					end,
-- 				},
-- 				window = {
-- 					completion = cmp.config.window.bordered(),
-- 					documentation = cmp.config.window.bordered(),
-- 				},
-- 				mapping = cmp.mapping.preset.insert({
-- 					['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 's' }),
-- 					['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i', 's' }),
-- 					['<C-b>'] = cmp.mapping.scroll_docs(-4),
-- 					['<C-f>'] = cmp.mapping.scroll_docs(4),
-- 					['<C-Space>'] = cmp.mapping.complete(),
-- 					['<C-e>'] = cmp.mapping.abort(),
-- 					['<CR>'] = cmp.mapping.confirm({ select = true }),
-- 				}),
-- 				sources = cmp.config.sources({
-- 					{ name = 'nvim_lsp' },
-- 					{ name = 'vsnip' }, -- Для пользователей vsnip
-- 				}, {
-- 					{ name = 'buffer' },
-- 				}),
-- 				-- formatting = {
-- 				--       before = require("tailwind-tools.cmp").lspkind_format
-- 				--     },
-- 			})
--
-- 			-- Настройка для командной строки
-- 			cmp.setup.cmdline({ '/', '?' }, {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = {
-- 					{ name = 'buffer' }
-- 				}
-- 			})
--
-- 			cmp.setup.cmdline(':', {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = cmp.config.sources({
-- 					{ name = 'path' }
-- 				}, {
-- 					{ name = 'cmdline' }
-- 				})
-- 			})
--
-- 			-- Настройка lspconfig
-- 			local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 			require('lspconfig')['emmet_ls'].setup {
-- 				capabilities = capabilities
-- 			}
-- 		end,
-- 	},
-- }
