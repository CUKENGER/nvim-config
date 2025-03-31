return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- Настройка bufferline
			require("bufferline").setup({
				options = {
					  diagnostics = 'nvim_lsp',
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "left",
							padding = 1,
						},
					},
					highlights = {
						fill = { bg = "#333333" },
						buffer_selected = { bold = true },
						diagnostic_selected = { bold = true },
						info_selected = { bold = true },
						info_diagnostic_selected = { bold = true },
						warning_selected = { bold = true },
						warning_diagnostic_selected = { bold = true },
						error_selected = { bold = true },
						error_diagnostic_selected = { bold = true },
					},
				},
			})
		end,
	},
}
