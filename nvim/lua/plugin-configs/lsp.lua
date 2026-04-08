local node_home = os.getenv("NODE_HOME")
local node_modules = node_home .. "/lib/node_modules"

local servers = {
    "pyright", "lua_ls", "cssls", "html", "jsonls", "bashls", "dockerls", "lemminx", "eslint",
    "texlab", "arduino_language_server", "rust_analyzer", "clangd", "phpactor",
    "kotlin_language_server", "angularls", "emmet_ls", "yamlls", "groovyls", "ts_ls", "tailwindcss",
    "jdtls"
}

vim.lsp.config("ts_ls", {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = node_modules .. "/@vue/typescript-plugin",
                languages = {"javascript", "typescript", "vue"}
            }
        }
    },
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact",
        "typescript.tsx", "vue"
    }
})

vim.lsp.config("emmet_ls", {
    filetypes = {
        "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass",
        "svelte", "typescriptreact", "vue", "htmlangular"
    }
})

vim.lsp.config("jsonls", {
    settings = {
        json = {schemas = require("schemastore").json.schemas(), validate = {enable = true}}
    }
})

vim.lsp.config("volar", {init_options = {typescript = {tsdk = node_modules .. "/typescript/lib"}}})

local angularls_cmd = {
    "ngserver", "--stdio", "--tsProbeLocations", node_modules, "--ngProbeLocations", node_modules
}
vim.lsp.config("angularls", {
    cmd = angularls_cmd,
    on_new_config = function(new_config) new_config.cmd = angularls_cmd end
})

vim.lsp.config("groovyls", {
    cmd = {
        "java", "-jar",
        "/home/felipe/Documents/groovy-language-server/build/libs/groovy-language-server-all.jar"
    }
})

vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath("config") and
                (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
                return
            end
        end
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {version = "LuaJIT", path = {"lua/?.lua", "lua/?/init.lua"}},
            workspace = {checkThirdParty = false, library = {vim.env.VIMRUNTIME}}
        })
    end,
    settings = {Lua = {}}
})

vim.lsp.config("jdtls", {
    cmd = {
        "/usr/bin/java", "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xmx1g", "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED", "--add-opens",
        "java.base/java.lang=ALL-UNNAMED", "-javaagent:/home/felipe/Documents/lombok/lombok.jar",
        "-jar",
        "/home/felipe/Documents/jdt-language-server/jdt-language-server-1.57.0-202602261110/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar",
        "-configuration",
        "/home/felipe/Documents/jdt-language-server/jdt-language-server-1.57.0-202602261110/config_linux",
        "-data", "/home/felipe/.jdtls-data/" .. vim.fn.getcwd():gsub("%/", "__")
    },
    root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
    settings = {
        java = {
            signatureHelp = {enabled = true},
            configuration = {
                runtimes = {
                    {name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk-amd64/"},
                    {name = "JavaSE-25", path = "/usr/lib/jvm/java-25-openjdk-amd64/"}
                }
            }
        }
    }
})

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
        vim.keymap.set({"n", "x"}, "<leader>ca", vim.lsp.buf.code_action, {buffer = true})
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {buffer = true})
        vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, {buffer = true})
    end
})

vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(event)
        local data = event.data
        local value = event.data.params.value
        local status = value.kind == "end" and "success" or "running"
        local title = vim.lsp.get_client_by_id(data.client_id).name

        local function trim_string(s)
            local max_len = vim.v.echospace - (title:len() + (": "):len() + ("..."):len())
            if s:len() > max_len then return s:sub(0, max_len) .. "..." end
            return s
        end

        local message = trim_string(value.kind == "end" and "Done" or value.message or value.title)

        vim.api.nvim_echo({{message}}, true, {
            id = "lsp." .. data.client_id,
            kind = "progress",
            source = "vim.lsp",
            title = title,
            status = status
        })
    end
})

