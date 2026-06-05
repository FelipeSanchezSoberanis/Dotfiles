local command_per_patterns = {
    {
        {"*.lua"}, {
            original_command = "lua-format --single-quote-to-double-quote --column-limit 100 -i \"%\"",
            new_command = "lua-format --single-quote-to-double-quote --column-limit 100"
        }
    }, --
    {
        {"*.java"},
        {original_command = "google-java-format -i \"%\"", new_command = "google-java-format -"}
    }, --
    {{"*.py"}, {original_command = "black -l 100 \"%\"", new_command = "black -l 100 --quiet -"}}, --
    {{"*.xml"}, {original_command = "xmllint --format \"%\" --output \"%\""}}, --
    {
        {
            "*.vue", "*.ts", "*.json", "*.html", "*.js", "*.scss", "*.tsx", "*.mjs", "*.jsx",
            "*.css", "*.yaml", "*.yml", "*.md", "*.mdx", "*.cjs", "*.jsonc"
        }, {original_command = "prettier -w \"%\"", new_command = "prettier \"%\""}
    }, --
    {{"*.ino", "*.c"}, {original_command = "clang-format --style=Google -i \"%\""}}, --
    {{"*.rs"}, {original_command = "rustfmt \"%\""}}, --
    {{"*.sql"}, {original_command = "pg_format \"%\" -o \"%\""}}, --
    {{"*.php"}, {original_command = "php-cs-fixer fix --rules=@PSR12 \"%\""}} --
}

for _, v in ipairs(command_per_patterns) do
    local patterns = v[1]
    local original_command = v[2].original_command
    local new_command = v[2].new_command

    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = patterns,
        callback = function(args)
            vim.keymap.set("n", "<leader>ff", function()
                if new_command ~= nil then
                    local saved_view = vim.fn.winsaveview()
                    vim.cmd("%!" .. new_command)
                    vim.fn.winrestview(saved_view)
                else
                    vim.cmd("w")
                    vim.cmd("silent !" .. original_command)
                end
            end, {buffer = args.buf})
        end
    })
end

vim.api.nvim_create_autocmd("BufWritePre",
                            {pattern = "*", callback = function() vim.cmd([[%s/\s\+$//e]]) end})

vim.api.nvim_create_autocmd("FileType",
                            {pattern = "*", callback = function() pcall(vim.treesitter.start) end})
