local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Esc" })
-- map("n", "q", "<Esc>", { desc = "Esc" })

map("n", "<leader>qq", ":q <CR>", { desc = "Quit" })

-- Navigation
map("n", "<c-k>", ":wincmd k<CR>", { desc = "Switch up" })
map("n", "<c-j>", ":wincmd j<CR>", { desc = "Switch down" })
map("n", "<c-h>", ":wincmd h<CR>", { desc = "Switch left" })
map("n", "<c-l>", ":wincmd l<CR>", { desc = "Switch right" })

-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Открыть Neotree слева
map("n", "<leader>e", function()
	vim.cmd("Neotree reveal")
end, { desc = "Neotree (left)" })

-- Splits
map("n", "|", ":vsplit<CR>", { desc = "Split horizontal" })
map("n", "\\", ":split<CR>", { desc = "Split vertical" })

-- Tabs
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next tab" })
map("n", "<s-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Prev tab" })
map("n", "<leader>xx", ":BufferLinePickClose<CR>", { desc = "Pick tab to close" })
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { desc = "Close others" })
-- map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close current" })
map("n", "<leader>bd", ":BufDel<CR>", { desc = "Close current buffer" })
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
-- map("n", "<leader>bc", ":BufferLineClose<CR>", { desc = "Close current bud buffer" })

-- LSP
-- map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Функция для улучшенного окна диагностик
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
		prefix = function(diagnostic, i)
			local icon = diagnostic.severity == vim.diagnostic.severity.ERROR and " "
				or diagnostic.severity == vim.diagnostic.severity.WARN and " "
				or diagnostic.severity == vim.diagnostic.severity.INFO and " "
				or " "
			return string.format("%d. %s", i, icon)
		end,
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):sub(1, 70)
			return string.format("%s: %s", diagnostic.source or "LSP", message)
		end,
		max_width = 80,
		max_height = math.min(#diagnostics + 2, 10),
		focusable = true,
		-- Убрали close_events, окно закрывается только явно
	})

	if not float_buf or not float_win then
		vim.notify("Не удалось открыть окно диагностики", vim.log.levels.ERROR)
		return
	end

	-- Переключаем фокус на окно диагностик
	vim.api.nvim_set_current_win(float_win)

	-- Настройка клавиш
	vim.api.nvim_buf_set_keymap(float_buf, "n", "q", "<cmd>q<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(float_buf, "n", "y", "", {
		noremap = true,
		silent = true,
		callback = function()
			local lines = {}
			for i, diagnostic in ipairs(diagnostics) do
				local icon = diagnostic.severity == vim.diagnostic.severity.ERROR and "ERROR"
					or diagnostic.severity == vim.diagnostic.severity.WARN and "WARN"
					or diagnostic.severity == vim.diagnostic.severity.INFO and "INFO"
					or "HINT"
				local message = string.format("[%s] %s: %s", icon, diagnostic.source or "LSP", diagnostic.message)
				table.insert(lines, message)
			end
			vim.fn.setreg("+", table.concat(lines, "\n"))
			vim.notify("Диагностики скопированы", vim.log.levels.INFO)
		end,
	})
	vim.api.nvim_buf_set_keymap(float_buf, "n", "j", "<Down>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(float_buf, "n", "k", "<Up>", { noremap = true, silent = true })

	-- Подсветка
	for i, diagnostic in ipairs(diagnostics) do
		local hl_group = diagnostic.severity == vim.diagnostic.severity.ERROR and "DiagnosticError"
			or diagnostic.severity == vim.diagnostic.severity.WARN and "DiagnosticWarn"
			or diagnostic.severity == vim.diagnostic.severity.INFO and "DiagnosticInfo"
			or "DiagnosticHint"
		vim.api.nvim_buf_add_highlight(float_buf, -1, hl_group, i - 1, 0, -1)
	end
end

-- Функция для улучшенного окна диагностик
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
		prefix = function(diagnostic, i)
			local icon = diagnostic.severity == vim.diagnostic.severity.ERROR and " "
				or diagnostic.severity == vim.diagnostic.severity.WARN and " "
				or diagnostic.severity == vim.diagnostic.severity.INFO and " "
				or " "
			return string.format("%d. %s", i, icon)
		end,
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):sub(1, 70)
			return string.format("%s: %s", diagnostic.source or "LSP", message)
		end,
		max_width = 80,
		max_height = math.min(#diagnostics + 2, 10),
		focusable = true,
		-- Убрали close_events, окно закрывается только явно
	})

	if not float_buf or not float_win then
		vim.notify("Не удалось открыть окно диагностики", vim.log.levels.ERROR)
		return
	end

	-- Переключаем фокус на окно диагностик
	vim.api.nvim_set_current_win(float_win)

	-- Настройка клавиш
	vim.api.nvim_buf_set_keymap(float_buf, "n", "q", "<cmd>q<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(float_buf, "n", "y", "", {
		noremap = true,
		silent = true,
		callback = function()
			local lines = {}
			for i, diagnostic in ipairs(diagnostics) do
				local icon = diagnostic.severity == vim.diagnostic.severity.ERROR and "ERROR"
					or diagnostic.severity == vim.diagnostic.severity.WARN and "WARN"
					or diagnostic.severity == vim.diagnostic.severity.INFO and "INFO"
					or "HINT"
				local message = string.format("[%s] %s: %s", icon, diagnostic.source or "LSP", diagnostic.message)
				table.insert(lines, message)
			end
			vim.fn.setreg("+", table.concat(lines, "\n"))
			vim.notify("Диагностики скопированы", vim.log.levels.INFO)
		end,
	})
	vim.api.nvim_buf_set_keymap(float_buf, "n", "j", "<Down>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(float_buf, "n", "k", "<Up>", { noremap = true, silent = true })

	-- Подсветка
	for i, diagnostic in ipairs(diagnostics) do
		local hl_group = diagnostic.severity == vim.diagnostic.severity.ERROR and "DiagnosticError"
			or diagnostic.severity == vim.diagnostic.severity.WARN and "DiagnosticWarn"
			or diagnostic.severity == vim.diagnostic.severity.INFO and "DiagnosticInfo"
			or "DiagnosticHint"
		vim.api.nvim_buf_add_highlight(float_buf, -1, hl_group, i - 1, 0, -1)
	end
end

local builtin = require("telescope.builtin")

map("n", "<leader>ld", open_diagnostic_float, { desc = "Показать диагностику строки" })

-- vim.keymap.set("n", "<leader>ld", open_diagnostic_float, { desc = "Line Diagnostics" })
map("n", "<leader>lm", ":TSToolsAddMissingImports<CR>", { desc = "Add Missing Imports" })
-- map("n", "gr", vim.lsp.buf.references, { desc = "References" })
-- map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

local function live_grep_right()
	builtin.live_grep({
		layout_strategy = "vertical",
		layout_config = {
			anchor = "E", -- Справа
			width = 0.4, -- 40% ширины
			height = 0.9, -- 90% высоты
			prompt_position = "top",
			mirror = false,
		},
		mappings = live_grep_mappings,
	})
end

map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>f/", live_grep_right, { desc = "Telescope live_grep_right" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- map("n", "gr", builtin.lsp_references, { noremap = true, silent = true, desc = "References" })
local telescope = require("telescope.builtin")

vim.keymap.set("n", "gd", function()
	telescope.lsp_definitions({})
end, { noremap = true, silent = true, desc = "Definitions" })

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.keymap.set("n", "gr", function()
	telescope.lsp_references({
		-- Обработка результатов
		entry_maker = function(entry)
			return {
				value = entry,
				display = string.format("%s:%d - %s", entry.filename, entry.lnum, entry.text),
				ordinal = entry.filename .. ":" .. entry.lnum, -- Для сортировки
				filename = entry.filename,
				lnum = entry.lnum,
				col = entry.col,
			}
		end,
		-- Фильтрация и сортировка
		results_processor = function(results)
			local filtered = {}
			local seen = {}
			for _, result in ipairs(results) do
				local key = result.filename .. ":" .. result.lnum .. ":" .. result.col
				if not seen[key] then
					table.insert(filtered, result)
					seen[key] = true
				end
			end
			-- Сортировка по имени файла
			table.sort(filtered, function(a, b)
				return a.filename < b.filename
			end)
			return filtered
		end,
		-- Дополнительные настройки отображения
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
			height = 0.8,
			width = 0.8,
		},
	})
end, { noremap = true, silent = true, desc = "References" })

map("n", "<leader>rp", ':%s/\\<<C-r><C-w>\\>/<C-r>"/g<CR>', { noremap = true, desc = "Replace all" })
map("v", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste without yank" })
-- conform
-- map("n", "<leader>lf", vim.lsp.buf.format(), { noremap = true, silent = true, desc = "Format" })

-- load the session for the current directory
vim.keymap.set("n", "<leader>ss", function()
	require("persistence").load()
end, { desc = "Load the session for the current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>sS", function()
	require("persistence").select()
end, { desc = "Select a session to load" })

-- load the last session
vim.keymap.set("n", "<leader>sl", function()
	require("persistence").load({ last = true })
end, { desc = "Last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>sd", function()
	require("persistence").stop()
end, { desc = "Session won't be saved" })

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "No Highlight" })

vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
vim.keymap.set("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>td", "<cmd>Trouble document_diagnostics<CR>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble quickfix<CR>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble loclist<CR>", { desc = "Location List" })

-- Переход к диагностикам
map("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Error" })
map("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous Error" })

local wk = require("which-key")

wk.add({
	{ "<leader>e", group = "Neotree" },
	{ "<leader>f", group = "Telescope" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
	{ "<leader>l", group = "LSP" },
	-- { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
	-- { "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Line Diagnostics" },
	{ "<leader>lm", "<cmd>TSToolsAddMissingImports<CR>", desc = "Add Missing Imports" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
	{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
	{
		"<leader>b",
		group = "buffers",
		expand = function()
			return require("which-key.extras").expand.buf()
		end,
	},
	-- { "<leader>q", "<cmd>qa!<cr>", desc = "Quit" },
	{ "<leader>xx", "<cmd>BufferLinePickClose<cr>", desc = "Pick tab to close" },
	{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
	{ "<leader>bd", desc = "Close current buffer" },
	{ "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next tab" },
	{ "<s-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev tab" },
	{ "|", "<cmd>vsplit<cr>", desc = "Split horizontal" },
	{ "\\", "<cmd>split<cr>", desc = "Split vertical" },
	{ "<c-k>", "<cmd>wincmd k<cr>", desc = "Switch up" },
	{ "<c-j>", "<cmd>wincmd j<cr>", desc = "Switch down" },
	{ "<c-h>", "<cmd>wincmd h<cr>", desc = "Switch left" },
	{ "<c-l>", "<cmd>wincmd l<cr>", desc = "Switch right" },
	{ "j", "v:count == 0 ? 'gj' : 'j'", desc = "Down", mode = { "n", "x" }, expr = true, silent = true },
	{ "<Down>", "v:count == 0 ? 'gj' : 'j'", desc = "Down", mode = { "n", "x" }, expr = true, silent = true },
	{ "k", "v:count == 0 ? 'gk' : 'k'", desc = "Up", mode = { "n", "x" }, expr = true, silent = true },
	{ "<Up>", "v:count == 0 ? 'gk' : 'k'", desc = "Up", mode = { "n", "x" }, expr = true, silent = true },
	{ "<leader>t", group = "Trouble" },
	{ "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "Toggle Trouble" },
	{ "<leader>tw", "<cmd>Trouble workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
	{ "<leader>td", "<cmd>Trouble document_diagnostics<CR>", desc = "Document Diagnostics" },
	{ "<leader>tq", "<cmd>Trouble quickfix<CR>", desc = "Quickfix" },
	{ "<leader>tl", "<cmd>Trouble loclist<CR>", desc = "Location List" },
	-- { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
}, { prefix = "<leader>" })
