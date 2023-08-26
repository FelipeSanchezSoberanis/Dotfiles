require('trouble').setup({
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    signs = {
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = true
})

vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)

