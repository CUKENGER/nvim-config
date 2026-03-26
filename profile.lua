
-- Включаем профилирование
vim.cmd("profile start /home/kol/nvim.log")
vim.cmd("profile func *")
vim.cmd("profile file *")

-- Через 1 минуту остановим профилирование автоматически
vim.defer_fn(function()
  vim.cmd("profile pause")
  print("Profiling finished, log saved to /home/kol/nvim.log")
end, 60000) -- 60000 ms = 1 минута
