return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"gmr458/vscode_modern_theme.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode_modern").setup({
				cursorline = true,
				transparent_background = false,
				nvim_tree_darker = true,
			})
			vim.cmd.colorscheme("vscode_modern")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"dstein64/nvim-scrollview",
		event = "BufRead",
		config = function()
			require("scrollview").setup({
				excluded_filetypes = { "nerdtree", "NvimTree" },
				signs_on_startup = { "all" },
				current_only = false,
				signs = {
					active = { "all" },
					line_number = false,
					cursor = true,
					error = true,
					warning = true,
					hint = true,
					info = true,
					search = true,
					git_diff = true,
					diagnostic = true,
					textobject = true,
					textobject_hl = true,
				},
			})
		end,
	},
	-- {
	--   "petertriho/nvim-scrollbar",
	--   event = "BufRead",
	--   config = function()
	--     require("scrollbar").setup()
	--   end,
	-- }
}
