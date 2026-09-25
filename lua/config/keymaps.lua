local map = vim.keymap.set
local builtin = require("telescope.builtin")

-- Базовые действия
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("n", "<leader>qq", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>yy", "<cmd>%y<CR>", { desc = "Yank entire buffer" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("v", "<leader>p", '"_dP', { desc = "Paste without yank" })
map("n", "<leader>rp", ':%s/\\<<C-r><C-w>\\>/<C-r>"/g<CR>', { desc = "Replace word under cursor" })

-- Навигация по сплитам
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Сплиты
map("n", "|", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "\\", "<cmd>split<CR>", { desc = "Split horizontal" })

-- Буферы (Bufferline / BufDel)
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>BufDel<CR>", { desc = "Close current buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
map("n", "<leader>bx", "<cmd>BufferLinePickClose<CR>", { desc = "Pick buffer to close" })

-- Neo-tree: фокус, если открыт в фоне; закрытие, если курсор уже внутри дерева
map("n", "<leader>e", function()
	if vim.bo.filetype == "neo-tree" then
		vim.cmd("Neotree close")
	else
		vim.cmd("Neotree focus reveal")
	end
end, { desc = "Focus or close NeoTree" })
-- Git
map("n", "<leader>gl", "<cmd>LazyGit<CR>", { desc = "LazyGit client" })

-- Telescope (Поиск)
map("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fw", function()
	builtin.live_grep({ default_text = vim.fn.expand("<cword>") })
end, { desc = "Live grep word under cursor" })
map("v", "<leader>fw", function()
	builtin.live_grep({ default_text = vim.fn.getreg('"') })
end, { desc = "Live grep visual selection" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep project" })

-- LSP навигация
map("n", "gd", builtin.lsp_definitions, { desc = "Goto definition" })
map("n", "gr", builtin.lsp_references, { desc = "Goto references" })
map("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
map("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })

-- Кастомное всплывающее окно диагностик
local function open_diagnostic_float()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
	if #diagnostics == 0 then
		vim.notify("Нет диагностик на текущей строке", vim.log.levels.INFO)
		return
	end

	local float_buf, float_win = vim.diagnostic.open_float({
		border = "rounded",
		scope = "line",
		source = "always",
		header = { " Диагностика ", "DiagnosticHeader" },
		prefix = function(d, i)
			local icon = d.severity == vim.diagnostic.severity.ERROR and " "
				or d.severity == vim.diagnostic.severity.WARN and " "
				or d.severity == vim.diagnostic.severity.INFO and " "
				or " "
			return string.format("%d. %s", i, icon)
		end,
		format = function(d)
			return string.format("%s: %s", d.source or "LSP", d.message:gsub("\n", " "):sub(1, 80))
		end,
		max_width = 85,
		focusable = true,
	})

	if not float_buf or not float_win then
		return
	end
	vim.api.nvim_set_current_win(float_win)
	vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = float_buf, silent = true })
	vim.keymap.set("n", "y", function()
		local lines = {}
		for _, d in ipairs(diagnostics) do
			table.insert(lines, string.format("[%s] %s: %s", d.source or "LSP", d.code or "", d.message))
		end
		vim.fn.setreg("+", table.concat(lines, "\n"))
		vim.notify("Скопировано в буфер", vim.log.levels.INFO)
	end, { buffer = float_buf, silent = true })
end

-- LSP действия (<leader>l)
map("n", "<leader>ld", open_diagnostic_float, { desc = "Line diagnostics details" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>lm", "<cmd>TSToolsAddMissingImports<CR>", { desc = "Add missing imports" })
map("n", "<leader>lf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format document" })

-- Trouble (<leader>t)
map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Document diagnostics" })
map("n", "<leader>tq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list" })
map("n", "<leader>tl", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list" })

-- Сессии Persistence (<leader>s)
map("n", "<leader>ss", function()
	require("persistence").load()
end, { desc = "Load session" })
map("n", "<leader>sS", function()
	require("persistence").select()
end, { desc = "Select session" })
map("n", "<leader>sl", function()
	require("persistence").load({ last = true })
end, { desc = "Last session" })
map("n", "<leader>sd", function()
	require("persistence").stop()
end, { desc = "Stop persistence" })
