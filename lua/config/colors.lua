function SetColor(color)
	color = color or "onedark_vivid"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "#120E27" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0E0A23" })
	-- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#6B7280", bg = "none" })
end

-- SetColor("vscode_modern")
SetColor("onedark")
