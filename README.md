# 🚀 Neovim Configuration

Личная конфигурация Neovim на Lua, оптимизированная под веб-разработку (TypeScript, React, Next.js, CSS/Tailwind) и системную работу в Linux.

---

## 📦 Системные требования и зависимости

Для сборки плагинов (Treesitter), работы LSP, линтеров, форматирования и быстрого поиска по файлам требуются установленные системные утилиты.

### 1. Установка в Arch Linux

Выполните установку основных зависимостей через `paru`:

```bash
paru -S --needed \
    neovim \
    git \
    base-devel \
    ripgrep \
    fd \
    fzf \
    nodejs \
    npm \
    unzip \
    curl \
    lazygit \
    wl-clipboard \
    xclip \
    tree-sitter \
    tree-sitter-cli
```

### Зачем нужны эти пакеты:
| Утилита | Для чего используется |
|---|---|
| `base-devel`, `tree-sitter-cli` | Компиляция C-парсеров для `nvim-treesitter` |
| `ripgrep` | Мгновенный текстовый поиск через Telescope (`<leader>fw`, `<leader>fg`) |
| `fd` | Быстрый поиск файлов без учета скрытых/игнорируемых (`<leader><leader>`) |
| `nodejs` & `npm` | Работа Mason и большинства LSP-серверов (`typescript`, `eslint_d`, `prettierd`, `tailwindcss`) |
| `wl-clipboard` / `xclip` | Синхронизация системного буфера обмена (`clipboard = "unnamedplus"`) под Wayland/X11 |
| `lazygit` | Терминальный Git-интерфейс (`<leader>gl`) |
| `unzip`, `curl` | Скачивание и распаковка бинарников через Mason |

---

### 2. Шрифты (Nerd Fonts)

Для корректного отображения иконок (`nvim-web-devicons`, Bufferline, Diagnostic, Neo-tree) необходим шрифт с поддержкой Nerd-символов:

```bash
paru -S ttf-jetbrains-mono-nerd
```
*Не забудьте выбрать установленный шрифт в настройках вашего эмулятора терминала (Alacritty / Kitty / WezTerm / Konsole).*

---

## 📥 Установка конфигурации

1. Склонируйте репозиторий в папку конфига Neovim:
   ```bash
   git clone <URL_ВАШЕГО_РЕПОЗИТОРИЯ> ~/.config/nvim
   ```

2. Запустите Neovim:
   ```bash
   nvim
   ```
   *Пакетный менеджер `lazy.nvim` скачается автоматически и начнет загрузку всех плагинов.*

3. Дождитесь завершения установки плагинов в открывшемся окне Lazy, затем перезапустите редактор.

4. Проверьте установку LSP-серверов и линтеров:
   ```vim
   :Mason
   ```
   Mason автоматически докачает: `prettierd`, `eslint_d`, `stylua`, `lua_ls`, `tailwindcss`, `emmet_ls`, `jsonls`.

5. Проверьте общее состояние окружения:
   ```vim
   :checkhealth
   ```

---

## ⌨️ Основные горячие клавиши (Hotkeys)

Клавиша Leader: `<Space>` (Пробел).

### Навигация и окна
* `jk` в insert mode — выйти в normal mode (`<Esc>`).
* `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` — перемещение между сплитами окон.
* `|` — вертикальный сплит.
* `\` — горизонтальный сплит.
* `<leader>qq` — закрыть окно / выйти.

### Файловый менеджер и поиск (Telescope / Neo-tree)
* `<leader>e` — открыть/закрыть Neo-tree с фокусировкой на текущем файле.
* `<leader><leader>` — поиск файлов по проекту.
* `<leader>fb` — список открытых буферов.
* `<leader>fw` — поиск слова под курсором по всему проекту (live grep).
* `<leader>gl` — запуск LazyGit.

### Табы и буферы (Bufferline / BufDel)
* `<Tab>` — следующий буфер.
* `<S-Tab>` — предыдущий буфер.
* `<leader>bd` — безопасно закрыть текущий буфер (без закрытия сплита).
* `<leader>bo` — закрыть все остальные буферы кроме активного.

### LSP, рефакторинг и форматирование
* `gd` — перейти к определению (Go to Definition).
* `gr` — показать ссылки на символ (References).
* `<leader>lr` — переименовать переменную/функцию (Rename).
* `<leader>la` — действия по коду (Code Action).
* `<leader>lf` — форматировать файл (`conform.nvim`: Prettier / StyLua).
* `<leader>ld` — детальное всплывающее окно диагностик на строке.
* `]e` / `[e` — перейти к следующей / предыдущей ошибке.

### Trouble (Диагностика)
* `<leader>tt` — список ошибок всего проекта (Trouble Workspace).
* `<leader>td` — список ошибок текущего файла.
* `<leader>tc` — полная проверка типов TypeScript (`tsc.nvim`) в Trouble.

---

## 🛠️ Возможные проблемы и решения

### Ошибка `error: cannot lock ref` при обновлении плагина
Если при `:Lazy sync` возникает ошибка блокировки git-ссылок в репозитории плагина:
```bash
rm -rf ~/.local/share/nvim/lazy/<имя_плагина>
```
И повторите `:Lazy sync`.
