local cmp = require("cmp")

cmp.setup({
    snippet = {expand = function(args) vim.snippet.expand(args.body) end},
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-j>"] = cmp.mapping(function() cmp.select_next_item() end, {"i", "s"}),
        ["<C-k>"] = cmp.mapping(function() cmp.select_prev_item() end, {"i", "s"}),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4)
    }),
    sources = cmp.config.sources({{name = "nvim_lsp"}}, {{name = "buffer"}})
})

cmp.setup.cmdline({"/", "?"},
                  {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}}),
    matching = {disallow_symbol_nonprefix_matching = false}
})
