return {
	{
		"okuuva/auto-save.nvim",
		version = "^1.0.0", -- или '*'
		lazy = false,
		cmd = "ASToggle",
		event = { "InsertLeave", "TextChanged" },
		opts = {
			enabled = true, -- по умолчанию включено
			debounce_delay = 150, -- как у тебя было ~135
			trigger_events = {
				immediate_save = { "BufLeave", "FocusLost" },
				defer_save = { "InsertLeave", "TextChanged" },
				cancel_deferred_save = { "InsertEnter" },
			},
			condition = function(buf)
				local filetype = vim.fn.getbufvar(buf, "&filetype")
				local filename = vim.fn.bufname(buf)

				-- Отключаем на конфигах и специальных буферах
				local excluded_ft = {
					"lua",
					"vim",
					"json",
					"yaml",
					"toml",
					"markdown",
					"gitcommit",
					"NvimTree",
					"neo-tree",
					"TelescopePrompt",
				}

				if vim.tbl_contains(excluded_ft, filetype) then
					return false
				end

				-- Можно добавить по имени файла
				if filename:match("init%.lua$") or filename:match("%.config") then
					return false
				end

				return vim.fn.getbufvar(buf, "&modifiable") == 1
			end,
			write_all_buffers = false,
			noautocmd = false,
			debug = true,
		},

		keys = {
			{
				"<leader>sa",
				function()
					require("auto-save").toggle()
				end,
				desc = "Toggle AutoSave",
				mode = "n",
			},
		},
	},
}
