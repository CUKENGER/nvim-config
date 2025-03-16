return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      -- Настройка bufferline
      require('bufferline').setup {
        options = {
          mode = "buffers", -- Установите "tabs" для отображения в виде вкладок
          numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = "bdelete! %d", -- Можно использовать "bdelete" для сохранения изменений или "bdelete! %d" для принудительного закрытия
          right_mouse_command = "bdelete! %d", -- Можно использовать "bdelete" для сохранения изменений или "bdelete! %d" для принудительного закрытия
          left_mouse_command = "buffer %d", -- Переключает на буфер по щелчку мыши
          middle_mouse_command = nil, -- Установите в nil, чтобы отключить кнопку мыши
          indicator = {
            icon = '▎', -- Символ для индикатора
            style = 'icon', -- | 'underline' | 'none',
          },
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 30,
          max_prefix_length = 30, -- Применяется только при использовании powerline
          tab_size = 21,
          diagnostics = false, -- | "nvim_lsp" | "coc",
          diagnostics_update_in_insert = false,
          offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true, -- Буферы будут сохранять свой порядок
          separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          sort_by = 'insert_after_current', -- |'insert_after_current' |'id' |'extension' |'relative_directory' |'directory' |'tabs' | function(buffer_a, buffer_b)
        },
        highlights = {
          -- Настройте цвета и стили здесь
        },
      }
    end,
  },
}
