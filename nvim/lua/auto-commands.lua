local command_per_patterns = {
    {{"*.lua"}, "lua-format --single-quote-to-double-quote --column-limit 100 -i %"}, --
    {{"*.java"}, "google-java-format -i %"}, --
    {{"*.py"}, "black -l 100 %"}, --
    {{"*.xml"}, "xmllint --format % --output"}, --
    {
        {"*.vue", "*.ts", "*.json", "*.html", "*.js", "*.scss", "*.tsx", "*.mjs", "*.jsx"},
        "prettier -w %"
    }, --
    {{"*.ino", "*.c"}, "clang-format --style=Google -i %"}, --
    {{"*.rs"}, "rustfmt %"} --
}

for _, v in ipairs(command_per_patterns) do
    local patterns = v[1]
    local command = v[2]

    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = patterns,
        callback = function(args)
            vim.keymap.set("n", "<leader>ff", function()
                vim.cmd("w")
                vim.cmd("silent !" .. command)
            end, {buffer = args.buf})
        end
    })
end
