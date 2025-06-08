return {
	{
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {
      check_ts = true, -- Интеграция с treesitter, если он у тебя есть
      disable_filetype = { 'TelescopePrompt', 'vim' }, -- Отключение для определенных типов файлов
      fast_wrap = {}, -- Быстрое оборачивание
    }
    -- Интеграция с nvim-cmp
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end
},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"windwp/nvim-autopairs",
			"hrsh7th/cmp-cmdline",
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
					completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:BorderBG",
          }),
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Только явный выбор
				}),
				sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 15, priority = 1000 }, -- LSP приоритетнее
          { name = "vsnip", max_item_count = 5, priority = 800 }, -- Сниппеты
          -- { name = "luasnip", max_item_count = 5, priority = 800 }, -- LuaSnip (если используешь)
          { name = "path", max_item_count = 5, priority = 600 }, -- Пути файлов
        }, {
          { name = "buffer", max_item_count = 5, priority = 400, option = { keyword_length = 3 } }, -- Буфер
        }),
				formatting = {
          -- format = lspkind.cmp_format({
          --   mode = "symbol_text", -- Иконка + текст
          --   maxwidth = 50, -- Ограничение ширины
          --   ellipsis_char = "...", -- Сокращение длинных элементов
          --   menu = { -- Метки источников
          --     nvim_lsp = "[LSP]",
          --     vsnip = "[Snippet]",
          --     luasnip = "[LuaSnip]",
          --     buffer = "[Buffer]",
          --     path = "[Path]",
          --     cmdline = "[Cmd]",
          --   },
          -- }),
        },
				sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset, -- Ближайшие к курсору
            cmp.config.compare.exact, -- Точные совпадения
            cmp.config.compare.score, -- Оценка релевантности
            cmp.config.compare.recently_used, -- Недавно использованные
            cmp.config.compare.locality, -- Локальные элементы
            cmp.config.compare.kind, -- Тип (функции, переменные)
            cmp.config.compare.sort_text, -- Алфавитный порядок
            cmp.config.compare.length, -- Короткие предложения
            cmp.config.compare.order, -- Порядок по умолчанию
          },
        },
				performance = {
          debounce = 60, -- Снижено для скорости
          throttle = 30, -- Снижено для отзывчивости
          fetching_timeout = 150, -- Уменьшено для быстрого ответа
          max_view_entries = 20, -- Ограничение отображаемых предложений
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
          { name = "cmdline", max_item_count = 5 },
        }),
      })

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("lspconfig")["emmet_ls"].setup({
        capabilities = capabilities,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "scss" }, -- Поддержка React
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
