require("aerial").setup({
    backends = {"lsp", "treesitter"},
    layout = {default_direction = "prefer_left", placement = "edge"},
    disable_max_lines = 100000,
    disable_max_size = 2000000,
    filter_kind = {
        "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct",
        "Array"
    }
})
