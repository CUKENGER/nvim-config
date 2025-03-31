return {
    'cjodo/convert.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim'
    },
    keys = {
        { "<leader>lcn", "<cmd>ConvertFindNext<CR>", desc = "Find next convertable unit" },
        { "<leader>lcc", "<cmd>ConvertFindCurrent<CR>", desc = "Find convertable unit in current line" },
        -- Add "v" to enable converting a selected region
        { "<leader>lca", "<cmd>ConvertAll<CR>", mode = {"n", "v"}, desc = "Convert all of a specified unit" },
    },
}
