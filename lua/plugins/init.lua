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
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"cljoly/telescope-repo.nvim",
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
	{
		"pocco81/auto-save.nvim",
		opts = {
			execution_message = {
				message = function()
					return ""
				end, -- Отключаем сообщение
				dim = 0.18, -- Неважно, но оставим
				cleaning_interval = 1250, -- Интервал очистки
			},
		},
	},
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	config = function()
	-- 		require("alpha").setup(require("alpha.themes.dashboard").config)
	-- 	end,
	-- },
}
