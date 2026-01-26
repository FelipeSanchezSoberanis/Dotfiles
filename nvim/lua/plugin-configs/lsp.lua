local node_modules = os.getenv("NODE_HOME") .. "/lib/node_modules"

local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

local servers = {
    "pyright", "lua_ls", "cssls", "html", "jsonls", "bashls", "dockerls", "lemminx", "eslint",
    "texlab", "arduino_language_server", "rust_analyzer", "clangd", "phpactor",
    "kotlin_language_server", "angularls", "emmet_ls", "yamlls", "groovyls", "ts_ls", "tailwindcss"
}
for _, server in ipairs(servers) do
    local setup = {capabilities = capabilities}

    if server == "ts_ls" then
        setup.init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = node_modules .. "/@vue/typescript-plugin",
                    languages = {"javascript", "typescript", "vue"}
                }
            }
        }
        setup.filetypes = {
            "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
            "typescript.tsx", "vue"
        }
    elseif server == "emmet_ls" then
        setup.filetypes = {
            "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass",
            "svelte", "typescriptreact", "vue", "htmlangular"
        }
    elseif server == "jsonls" then
        setup.settings = {
            json = {schemas = require("schemastore").json.schemas(), validate = {enable = true}}
        }
    elseif server == "volar" then
        setup.init_options = {typescript = {tsdk = node_modules .. "/typescript/lib"}}
    elseif server == "angularls" then
        local cmd = {
            "ngserver", "--stdio", "--tsProbeLocations", node_modules, "--ngProbeLocations",
            node_modules
        }
        setup.cmd = cmd
        setup.on_new_config = function(new_config) new_config.cmd = cmd end
    elseif server == "groovyls" then
        setup.cmd = {
            "java", "-jar",
            "/home/felipe/Documents/groovy-language-server/build/libs/groovy-language-server-all.jar"
        }
    elseif server == "lua_ls" then
        setup.on_init = function(client)
            print("on_init")
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath("config") and
                    (vim.uv.fs_stat(path .. "/.luarc.json") or
                        vim.uv.fs_stat(path .. "/.luarc.jsonc")) then return end
            end
            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {version = "LuaJIT", path = {"lua/?.lua", "lua/?/init.lua"}},
                workspace = {checkThirdParty = false, library = {vim.env.VIMRUNTIME}}
            })
        end
        setup.settings = {Lua = {}}
    end

    vim.lsp.config[server] = setup
end
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = true})
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count = 1, float = true}) end,
                       {buffer = true})
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count = -1, float = true}) end,
                       {buffer = true})
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = true})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {buffer = true})
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {buffer = true})
        vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {buffer = true})
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer = true})
        vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, {buffer = true})
    end
})
