local NODE_MODULES = os.getenv("NODE_HOME") .. "/lib/node_modules"

local cmp = require("cmp")
local nvim_lsp = require("lspconfig")

cmp.setup({
    window = {completion = {border = "single"}, documentation = {border = "single"}},
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
    mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
        ["<C-k>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
    },
    sources = cmp.config.sources({{name = "nvim_lsp"}, {name = "ultisnips"}}, {{name = "buffer"}})
})

cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})
cmp.setup.cmdline(":", {sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})})

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}

    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl",
                   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

require("lspconfig.ui.windows").default_options.border = "single"
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
for _, lsp in ipairs(servers) do
    if (lsp == "cssls" or lsp == "jsonls" or lsp == "eslint") then
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    elseif (lsp == "angularls") then
        local cmd = {
            "ngserver", "--stdio", "--tsProbeLocations", NODE_MODULES, "--ngProbeLocations",
            NODE_MODULES
        }
        nvim_lsp[lsp].setup {
            filetypes = {"typescript", "html", "typescriptreact", "typescript.tsx", "angular.html"},
            on_attach = on_attach,
            cmd = cmd,
            on_new_config = function(new_config) new_config.cmd = cmd end,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    elseif (lsp == "lua_ls") then
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {version = "LuaJIT"},
                    diagnostics = {globals = {"vim"}},
                    workspace = {library = vim.api.nvim_get_runtime_file("", true)},
                    telemetry = {enable = false}
                }
            },
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    elseif (lsp == "groovyls") then
        nvim_lsp[lsp].setup {
            cmd = {
                "java", "-jar",
                "/home/felipe/Documents/groovy-language-server/build/libs/groovy-language-server-all.jar"
            },
            on_attach = on_attach,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    elseif (lsp == "tsserver") then
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}},
            init_options = {
                host_info = "neovim",
                tsserver = {path = NODE_MODULES .. "/typescript/lib/tsserver.js"},
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = NODE_MODULES .. "/@vue/typescript-plugin",
                        languages = {"javascript", "typescript", "vue"}
                    }
                }
            },
            filetypes = {"javascript", "typescript", "vue", "javascriptreact", "typescriptreact"}
        }
    elseif (lsp == "html") then
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        nvim_lsp[lsp].setup {
            filetypes = {"html", "templ", "angular.html"},
            on_attach = on_attach,
            capabilities = capabilities,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    elseif (lsp == "emmet_ls") then
        nvim_lsp[lsp].setup {
            filetypes = {
                "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug",
                "sass", "scss", "svelte", "typescriptreact", "vue", "angular.html"
            },
            on_attach = on_attach,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    else
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            workspace = {didChangeWatchedFiles = {dynamicRegistration = true}}
        }
    end
end
