return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		spec = {
			{ "<leader>b", group = "Buffers", icon = "󰓩 " },
			{ "<leader>f", group = "Find / Telescope", icon = "󰍉 " },
			{ "<leader>g", group = "Git", icon = "󰊢 " },
			{ "<leader>l", group = "LSP / Code", icon = "󰘦 " },
			{ "<leader>s", group = "Session", icon = "󰁯 " },
			{ "<leader>t", group = "Trouble / Diagnostics", icon = "󱍼 " },
			{ "<leader>q", group = "Quit", icon = "󰩈 " },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},
	},
}
