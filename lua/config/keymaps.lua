local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Esc" })
map("n", "q", "<Esc>", { desc = "Esc" })

map("n", "<leader>qq", ":qa! <CR>", { desc = "Quit" })

-- Navigation
map("n", "<c-k>", ":wincmd k<CR>", { desc = "Switch up" })
map("n", "<c-j>", ":wincmd j<CR>", { desc = "Switch down" })
map("n", "<c-h>", ":wincmd h<CR>", { desc = "Switch left" })
map("n", "<c-l>", ":wincmd l<CR>", { desc = "Switch right" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
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

-- LSP
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>lm", ":TSToolsAddMissingImports<CR>", { desc = "Add Missing Imports" })
-- map("n", "gr", vim.lsp.buf.references, { desc = "References" })
-- map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })

-- Telescope
local builtin = require("telescope.builtin")

map("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>f/", builtin.live_grep, { desc = "Telescope live grep" })
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

vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "No Highlight" })

local wk = require("which-key")

wk.add({
	{ "<leader>e", group = "Neotree" },
	{ "<leader>el", "<cmd>Neotree position=left<cr>", desc = "Left" },
	{ "<leader>f", group = "Telescope" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
	{ "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Line Diagnostics" },
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
	{ "<leader>q", "<cmd>qa!<cr>", desc = "Quit" },
	{ "<leader>xx", "<cmd>BufferLinePickClose<cr>", desc = "Pick tab to close" },
	{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close others" },
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
	-- { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
}, { prefix = "<leader>" })
