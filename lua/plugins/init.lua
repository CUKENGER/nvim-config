return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	{
    "cljoly/telescope-repo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
{
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
      },
      pickers = {
        lsp_code_actions = {
          theme = "dropdown",
          previewer = false,
          layout_config = { width = 0.5, height = 0.4 },
        },
      },
    })
  end,
},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},

	{ "Mofiqul/vscode.nvim" },
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			autosave = false, -- Отключаем автосохранение
		},
		keys = {
			{
				"<leader>ss",
				function()
					require("persistence").load()
				end,
				desc = "Load session",
			},
			{
				"<leader>sS",
				function()
					require("persistence").select()
				end,
				desc = "Select session",
			},
			{
				"<leader>sl",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Last session",
			},
			{
				"<leader>sd",
				function()
					require("persistence").stop()
				end,
				desc = "Stop session",
			},
		},
	},
	{'ojroques/nvim-bufdel'},
	{
		"pocco81/auto-save.nvim",
		event = { "InsertLeave", "TextChanged" },
		opts = {
			enabled = true,                   -- Автосохранение включено по умолчанию
			execution_message = {
				message = function() return "" end, -- Отключено сообщение
				dim = 0.18,
				cleaning_interval = 1250,
			},
			trigger = {
				events = { "TextChanged" },                  -- Сохранение при выходе из insert mode или изменении текста
			},
			condition = function(buf)                      -- Условие для сохранения
				return vim.fn.getbufvar(buf, "&modifiable") == 1 -- Сохранять только изменяемые буферы
						and vim.fn.bufname(buf) ~= ""            -- Игнорировать безымянные буферы
			end,
			write_all_buffers = false,                     -- Сохранять только текущий буфер
			debounce_delay = 135,                          -- Задержка 135 мс для отложенного сохранения
			debug = false,                                 -- Отключить отладочные логи
		},
		keys = {
			{
				"<leader>sa",
				":AutoSaveToggle<CR>",
				desc = "Toggle AutoSave",
				mode = "n",
			},
		},
	}
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.dashboard").config)
	-- 	end,
	-- },
}
