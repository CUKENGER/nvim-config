require('config.lazy')
require('config.keymaps')
require('config.options')
require("config.colors")


-- Предотвращаем выход при закрытии последнего буфера
-- vim.api.nvim_create_autocmd("BufDelete", {
-- 	callback = function()
-- 		local buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
-- 		if buffers == 1 then
-- 			vim.cmd("enew")
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("WinClosed", {
	callback = function()
		vim.schedule(function()
			local wins = vim.api.nvim_list_wins()
			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].buflisted then
					return
				end
			end
			vim.cmd("enew")
		end)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = "FileExplorer",
  callback = function()
    vim.api.nvim_clear_autocmds({ group = "FileExplorer", event = "VimEnter" })
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

