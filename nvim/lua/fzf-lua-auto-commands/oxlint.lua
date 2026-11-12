local fzf_lua = require("fzf-lua")
local fzf_lua_utils = require("fzf-lua.utils")

local icon_per_severity = {error = "❌", warning = "⚠️"}

local function remove_ansi(str) return string.gsub(str, "\27%[[0-9;]*m", "") end

local function get_command()
    local options = {"npx oxlint", "oxlint"}
    for _, option in ipairs(options) do
        vim.fn.system(vim.fn.join({option, "--version"}, " "))
        if vim.v.shell_error == 0 then return option end
    end
    return nil
end

local function oxlint_fzf_lua()
    local command = get_command()
    if not command then
        vim.notify("Oxlint installation not found", vim.log.levels.ERROR)
        return
    end

    local output = vim.fn.system(vim.fn.join({command, "--format", "json"}, " "))
    local json_string = output:match("{.+}")
    local success, json = pcall(vim.fn.json_decode, json_string)
    if not success or not json then
        vim.notify("Error parsing json", vim.log.levels.ERROR)
        return
    end

    if #json.diagnostics == 0 then
        vim.notify("Oxlint reported no errors", vim.log.levels.INFO)
        return
    end

    local entries = {}
    local diagnostic_per_entry = {}
    for _, diagnostic in ipairs(json.diagnostics) do
        local icon = icon_per_severity[diagnostic.severity]
        local filename = fzf_lua_utils.ansi_from_hl("Directory", diagnostic.filename)
        local line = diagnostic.labels[1].span.line
        local column = diagnostic.labels[1].span.column
        local line_column = fzf_lua_utils.ansi_from_hl("Comment",
                                                       string.format("(%s:%s)", line, column))
        local message = diagnostic.message

        local display_text = string.format("%s %s%s: %s", icon, filename, line_column, message)
        local entry = string.format("%s:%s:%s\t%s", filename, line, column, display_text)
        diagnostic_per_entry[remove_ansi(entry)] = diagnostic
        table.insert(entries, entry)
    end

    fzf_lua.fzf_exec(entries, {
        prompt = "Oxlint>",
        previewer = "builtin",
        fzf_opts = {["--delimiter"] = "\t", ["--with-nth"] = "2", ["--wrap"] = ""},
        actions = {
            default = function(selected)
                local entry = selected[1]
                local diagnostic = diagnostic_per_entry[remove_ansi(entry)]
                local filename = diagnostic.filename
                local line = diagnostic.labels[1].span.line
                local column = diagnostic.labels[1].span.column
                vim.cmd("edit " .. vim.fn.fnameescape(filename))
                vim.api.nvim_win_set_cursor(0, {line, column - 1})
            end
        }
    })
end

vim.api.nvim_create_user_command("OxlintFzfLua", oxlint_fzf_lua, {})
