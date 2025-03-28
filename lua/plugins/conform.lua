return {
	{
  'stevearc/conform.nvim',
  opts = {},
	config = function() 
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  vim.api.nvim_set_keymap(
        "n",                    -- Режим normal
        "<leader>lf",            -- Сочетание клавиш (например, <leader>f = \,f по умолчанию)
        "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>",
        { noremap = true, silent = true, desc = "format"}
      )
})
	end,
}
}
