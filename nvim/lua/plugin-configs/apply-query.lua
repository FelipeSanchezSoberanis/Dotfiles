vim.api.nvim_create_user_command("ApplyQuery", function()
    local query_string = vim.fn.getreg("q")
    if query_string == "" then
        vim.notify("Register q is empty", vim.log.levels.ERROR)
        return
    end

    local current_buf = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[current_buf].filetype
    local lang = vim.treesitter.language.get_lang(filetype)

    local ok, query = pcall(vim.treesitter.query.parse, lang, query_string)
    if not ok then
        vim.notify("Invalid Treesitter query:\n" .. tostring(query), vim.log.levels.ERROR)
        return
    end

    local parser = vim.treesitter.get_parser(current_buf, lang)
    if parser == nil then
        vim.notify("Parser not found", vim.log.levels.ERROR)
        return
    end

    local tree = parser:parse()[1]
    local root = tree:root()

    local qf_list = {}
    for id, node in query:iter_captures(root, current_buf) do
        local capture_name = query.captures[id]
        if string.find(capture_name, "_", 1, true) ~= 1 then
            local row, col = node:range()

            local text = vim.treesitter.get_node_text(node, current_buf)
            local first_line = text:match("([^\n]+)")

            table.insert(qf_list, {
                bufnr = current_buf,
                lnum = row + 1,
                col = col + 1,
                text = string.format("@%s: %s", capture_name, first_line)
            })
        end
    end

    if #qf_list == 0 then
        vim.notify("No matches found for query", vim.log.levels.INFO)
        return
    end

    vim.fn.setqflist({}, " ", {title = "ApplyQuery", items = qf_list})
    vim.cmd("copen")
end, {desc = "Run treesitter query from register q and populate quickfix list with results"})
