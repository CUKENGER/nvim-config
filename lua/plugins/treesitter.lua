return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "css", "scss", "javascript", "typescript", "tsx" }, -- Поддержка CSS и SCSS
				highlight = { enable = true },
				autotag = {
					enable = true,
				},
			})
		end,
	},
}
