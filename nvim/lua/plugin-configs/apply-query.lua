local namespace = vim.api.nvim_create_namespace("apply_query_highlights")

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
            local start_row, start_col, end_row, end_col = node:range()

            local text = vim.treesitter.get_node_text(node, current_buf)
            local first_line = text:match("([^\n]+)")

            table.insert(qf_list, {
                bufnr = current_buf,
                lnum = start_row + 1,
                col = start_col + 1,
                text = string.format("@%s: %s", capture_name, first_line),
                end_row = end_row + 1,
                end_col = end_col + 1
            })
        end
    end

    if #qf_list == 0 then
        vim.notify("No matches found for query", vim.log.levels.INFO)
        return
    end

    for i = 1, #qf_list do
        local qf_entry = qf_list[i]
        local bufnr = qf_entry.bufnr
        local start_row = qf_entry.lnum - 1
        local start_col = qf_entry.col - 1
        local end_row = qf_entry.end_row - 1
        local end_col = qf_entry.end_col - 1
        vim.hl.range(bufnr, namespace, "Search", {start_row, start_col}, {end_row, end_col})
    end
    vim.fn.setqflist({}, " ", {title = "ApplyQuery", items = qf_list})
    vim.cmd("copen")
end, {desc = "Run treesitter query from register q and populate quickfix list with results"})

vim.api.nvim_create_user_command("ClearQuery", function()
    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
end, {desc = "Clear highlights created by ApplyQuery"})
