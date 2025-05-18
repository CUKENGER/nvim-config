return {
  {
    "nvim-neotest/neotest",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "marilari88/neotest-vitest", -- Добавляем адаптер для Vitest
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest") {
            -- Опциональные настройки для Vitest
            vitestCommand = "npx vitest", -- Команда для запуска Vitest
            vitestConfigFile = vim.fn.getcwd() .. "/vitest.config.ts", -- Путь к конфигу Vitest
            env = { NODE_ENV = "test" }, -- Переменные окружения
          },
        },
        -- Дополнительные настройки Neotest
        output = {
          enabled = true,
          open_on_run = true, -- Открывать вывод тестов при запуске
        },
        summary = {
          mappings = {
            run = "r",
            debug = "d",
            stop = "s",
          },
        },
      })
    end,
    keys = {
      { "<leader>ttt", "<cmd>lua require('neotest').run.run()<CR>", desc = "Run nearest test", mode = "n" },
      { "<leader>ttf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Run all tests in file", mode = "n" },
      { "<leader>tts", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle test summary", mode = "n" },
      { "<leader>tto", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", desc = "Open test output", mode = "n" },
    },
  },
}
