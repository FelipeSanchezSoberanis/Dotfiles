local lspconfig = require("lspconfig")
local cmp = require("cmp")
local lspconfig_ui_windows = require("lspconfig.ui.windows")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig_ui_windows.default_options.border = "single"
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = "single"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local servers = {
    "pyright", "lua_ls", "cssls", "html", "jsonls", "bashls", "dockerls", "lemminx", "eslint",
    "texlab", "arduino_language_server", "rust_analyzer", "clangd", "phpactor",
    "kotlin_language_server", "angularls", "emmet_ls", "yamlls", "groovyls", "tsserver", "volar"
}
for _, server in ipairs(servers) do lspconfig[server].setup({capabilities = capabilities}) end

cmp.setup({
    window = {completion = {border = "single"}, documentation = {border = "single"}},
    sources = {{name = "nvim_lsp"}, {name = "ultisnips"}, {name = "buffer"}},
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping(function() cmp.select_next_item() end, {"i", "s"}),
        ["<C-k>"] = cmp.mapping(function() cmp.select_prev_item() end, {"i", "s"}),
        ["<CR>"] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace, select = true},
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4)
    })
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = true})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer = true})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer = true})
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = true})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {buffer = true})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = true})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = true})
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer = true})
    end
})
