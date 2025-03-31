return {
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	{
		"farias-hecdin/CSSVarViewer",
		ft = "css",
		config = true,
		-- If you want to configure some options, replace the previous line with:
		-- config = function()
		-- end,
	},
}
