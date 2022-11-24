require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
        -- additional_vim_regex_highlighting = {"html", "vue", "scss"}
    },
    indent = {enable = true}
}
