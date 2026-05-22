return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",        -- важно после архивации
    lazy = false,             -- грузим обязательно
    build = ":TSUpdate",
    priority = 1000,

    config = function()
      -- Защита от ошибки, если плагин ещё не полностью загрузился
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("nvim-treesitter not ready yet, retrying...", vim.log.levels.WARN)
        return
      end

      configs.setup({
        ensure_installed = {
          "typescript", "tsx", "javascript",
          "json", "css", "scss", "html",
          "lua", "markdown", "markdown_inline"
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },
}
