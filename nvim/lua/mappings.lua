local gitsigns = require("gitsigns")
local fzf_lua = require("fzf-lua")

vim.keymap.set("n", " ", function() end)
vim.keymap.set("n", "<c-p>", function() fzf_lua.files({hidden = true}) end)
vim.keymap.set("n", "<leader>a<c-p>", ":Files<CR>")
vim.keymap.set("n", "<c-b>", fzf_lua.buffers)
vim.keymap.set("n", "<c-f>", fzf_lua.live_grep)
vim.keymap.set("x", "<c-f>", fzf_lua.grep_visual)
vim.keymap.set("n", "<leader>fr", fzf_lua.resume)
vim.keymap.set("n", "<leader>nt", ":NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>")
vim.keymap.set("n", "<leader>nf", ":NERDTreeFind<CR>:NERDTreeRefreshRoot<CR>")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "<leader>ww", function() vim.cmd([[set wrap!]]) end)
vim.keymap.set("x", "<leader>ss", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])
vim.keymap.set("n", "]c", function()
    if vim.wo.diff then
        vim.cmd.normal({"]c", bang = true})
    else
        gitsigns.nav_hunk("next")
    end
end)
vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
        vim.cmd.normal({"[c", bang = true})
    else
        gitsigns.nav_hunk("prev")
    end
end)
vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
vim.keymap.set("x", "<leader>hs",
               function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set("x", "<leader>hr",
               function() gitsigns.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer)
vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk)
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer)
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line {full = true} end)
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
vim.keymap.set("n", "<leader>hd", gitsigns.diffthis)
vim.keymap.set("n", "<leader>hD", function() gitsigns.diffthis("~") end)
vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted)
vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
vim.keymap.set("n", "<leader>cq", ":cclose<CR>")
vim.keymap.set("x", "/", "<esc>/\\%V")
vim.keymap.set("x", "?", "<esc>?\\%V")
vim.keymap.set("n", "<leader>at", ":AerialToggle!<CR>")
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end,
               {desc = "Next todo comment"})
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end,
               {desc = "Previous todo comment"})
vim.keymap.set("n", "<leader>tq", function() vim.cmd([[:TodoQuickFix]]) end,
               {desc = "Open todo comments in quick fix"})
vim.keymap.set("x", "<leader>ob", function()
    local region = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."))
    local text = vim.trim(table.concat(region, "\n"))
    local command = "xdg-open '" .. text .. "'"
    local status = os.execute(command)
    if status == 0 then return end
    vim.api.nvim_echo({{"Command \"" .. command .. "\" exited with status " .. status}}, true,
                      {err = true})
end)

