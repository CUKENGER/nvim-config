return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    position = "bottom", -- Расположение панели
    height = 10, -- Высота панели
    icons = true, -- Использовать иконки
    mode = "workspace_diagnostics", -- По умолчанию показывать диагностику всего проекта
    fold_open = "▾", -- Символ для открытых узлов
    fold_closed = "▸", -- Символ для закрытых узлов
    action_keys = {
      close = "q", -- Закрыть Trouble клавишей q
      cancel = "<esc>", -- Отмена
      jump = { "<cr>", "<tab>" }, -- Перейти к ошибке
    },
    auto_close = true, -- Автозакрытие при отсутствии диагностики
  },
}
