return {
  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup({
        auto_open_qflist = false,
        use_trouble_qflist = true, -- Отправляет ошибки в Trouble
        flags = {
          build = true, -- Проверяет весь проект
        },
      })
      -- Привязка для запуска tsc и открытия Trouble
      vim.keymap.set("n", "<leader>tc", function()
        vim.cmd("TSC") -- Запускает tsc.nvim
        require("trouble").open("quickfix") -- Открывает Trouble с quickfix
      end, { desc = "Run TSC and show errors in Trouble" })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      use_diagnostic_signs = true,
      auto_close = false, -- Не закрывать автоматически
      auto_fold = false, -- Не сворачивать файлы по умолчанию
      group = true, -- Группировать по файлам
      mode = "workspace_diagnostics", -- По умолчанию показывать диагностики проекта
      severity = nil, -- Показывать все уровни (ERROR, WARN, INFO, HINT)
      win_config = {
        border = "rounded",
        position = "bottom",
        height = 15,
      },
      keys = {
        ["<CR>"] = "jump", -- Перейти к ошибке
        ["<2-LeftMouse>"] = "jump", -- Двойной клик для перехода
        ["q"] = "close", -- Закрыть Trouble
        ["<C-j>"] = "next", -- Следующая ошибка
        ["<C-k>"] = "prev", -- Предыдущая ошибка
      },
      icons = {
        indent = "│ ",
        folder_closed = " ",
        folder_open = " ",
        kinds = {
          Error = " ",
          Warning = " ",
          Info = " ",
          Hint = " ",
        },
      },
    },
    keys = {
      { "<leader>tt", "<cmd>Trouble toggle<cr>", desc = "Toggle Trouble" },
      { "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
      { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
      { "<leader>tq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix List" },
      { "<leader>tl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>tc", desc = "Run TSC and show errors" }, -- Добавлено для tsc.nvim
    },
  },
}
