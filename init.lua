require('config.lazy')
require('config.keymaps')
require('config.options')
require("config.colors")


-- Предотвращаем выход при закрытии последнего буфера
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function()
        local buffers = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
        if buffers == 1 then
            vim.cmd("enew")
        end
    end,
})
