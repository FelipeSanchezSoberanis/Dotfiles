require("catppuccin").setup({
    flavor = "mocha",
    transparent_background = true,
    integrations = {treesitter = true, cmp = true},
    custom_highlights = function(colors)
        local catppuccin_options = require("catppuccin").options
        return {
            ["@variable.member"] = {fg = colors.lavender},
            ["@module"] = {
                fg = colors.lavender,
                style = catppuccin_options.styles.miscs or {"italic"}
            },
            ["@string.special.url"] = {fg = colors.rosewater, style = {"italic", "underline"}},
            ["@type.builtin"] = {
                fg = colors.yellow,
                style = catppuccin_options.styles.properties or {"italic"}
            },
            ["@property"] = {
                fg = colors.lavender,
                style = catppuccin_options.styles.properties or {}
            },
            ["@constructor"] = {fg = colors.sapphire},
            ["@keyword.operator"] = {link = "Operator"},
            ["@keyword.export"] = {fg = colors.sky, style = catppuccin_options.styles.keywords},
            ["@markup.strong"] = {fg = colors.maroon, style = {"bold"}},
            ["@markup.italic"] = {fg = colors.maroon, style = {"italic"}},
            ["@markup.heading"] = {fg = colors.blue, style = {"bold"}},
            ["@markup.quote"] = {fg = colors.maroon, style = {"bold"}},
            ["@markup.link"] = {link = "Tag"},
            ["@markup.link.label"] = {link = "Label"},
            ["@markup.link.url"] = {fg = colors.rosewater, style = {"italic", "underline"}},
            ["@markup.raw"] = {fg = colors.teal},
            ["@markup.list"] = {link = "Special"},
            ["@tag"] = {fg = colors.mauve},
            ["@tag.attribute"] = {
                fg = colors.teal,
                style = catppuccin_options.styles.miscs or {"italic"}
            },
            ["@tag.delimiter"] = {fg = colors.sky},
            ["@property.css"] = {fg = colors.lavender},
            ["@property.id.css"] = {fg = colors.blue},
            ["@type.tag.css"] = {fg = colors.mauve},
            ["@string.plain.css"] = {fg = colors.peach},
            ["@constructor.lua"] = {fg = colors.flamingo},
            ["@property.typescript"] = {
                fg = colors.lavender,
                style = catppuccin_options.styles.properties or {}
            },
            ["@constructor.typescript"] = {fg = colors.lavender},
            ["@constructor.tsx"] = {fg = colors.lavender},
            ["@tag.attribute.tsx"] = {
                fg = colors.teal,
                style = catppuccin_options.styles.miscs or {"italic"}
            },
            ["@type.builtin.c"] = {fg = colors.yellow, style = {}},
            ["@type.builtin.cpp"] = {fg = colors.yellow, style = {}}
        }
    end
});

vim.cmd.colorscheme("catppuccin")

