local cmp = require("cmp")
local compare = cmp.config.compare
local Kind = cmp.lsp.CompletionItemKind

local function fields_properties_methods(entry_1, entry_2)
    local function should_prioritize_entry(entry)
        local kind = entry:get_kind()
        return kind == Kind.Field or kind == Kind.Property or kind == Kind.Method
    end

    local prioritize_entry_1 = should_prioritize_entry(entry_1)
    local prioritize_entry_2 = should_prioritize_entry(entry_2)

    if prioritize_entry_1 ~= prioritize_entry_2 then return prioritize_entry_1 end
    return nil
end

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
    sources = cmp.config.sources({{name = "nvim_lsp"}}, {{name = "buffer"}}),
    sorting = {
        priority_weight = 2,
        comparators = {
            fields_properties_methods, compare.offset, compare.exact, compare.scopes, compare.score,
            compare.recently_used, compare.locality, compare.kind, compare.sort_text,
            compare.length, compare.order
        }
    }
})

cmp.setup.cmdline({"/", "?"},
                  {mapping = cmp.mapping.preset.cmdline(), sources = {{name = "buffer"}}})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}}),
    matching = {disallow_symbol_nonprefix_matching = false}
})
