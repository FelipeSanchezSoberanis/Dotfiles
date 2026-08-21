local function trimmedCurrentFilepath()
    local filename = vim.fn.expand("%:t")
    local directory = vim.fn.expand("%:h")
    local available_space = math.floor(vim.v.echospace * 0.45)
    local available_directory_space = available_space - filename:len() - 4
    if (available_directory_space < directory:len()) then
        return vim.fs.joinpath(directory:sub(0, available_directory_space), "...", filename)
    else
        return vim.fs.joinpath(directory, filename)
    end
end

require("lualine").setup({
    sections = {
        lualine_c = {trimmedCurrentFilepath},
        lualine_x = {{"searchcount", maxcount = 10000}, "encoding", "fileformat", "filetype"}
    }
})
