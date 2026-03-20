require("aerial").setup({
    backends = {"lsp", "treesitter"},
    layout = {default_direction = "prefer_left"},
    disable_max_lines = 100000,
    disable_max_size = 2000000
})
