require("catppuccin").setup({
    flavor = "mocha",
    transparent_background = true,
    integrations = {treesitter = true, cmp = true}
});

vim.cmd.colorscheme "catppuccin"
vim.g.airline_theme = "catppuccin"

