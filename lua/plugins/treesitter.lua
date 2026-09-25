return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"scss",
					"json",
					"markdown_inline",
					"bash",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- Автозакрытие и переименование HTML/JSX тегов
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},
}
