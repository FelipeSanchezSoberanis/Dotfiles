require("lualine").setup({
    sections = {
        lualine_x = {{"searchcount", maxcount = 10000}, "encoding", "fileformat", "filetype"}
    }
})
