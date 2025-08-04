local gitsigns = require("gitsigns")
local rgflow = require("rgflow")

local function open_rgflow_with_optional_visual_selection()
    local mode = vim.api.nvim_get_mode().mode
    local selected_text = nil

    if mode == "v" then
        local cursor_position = vim.fn.getpos(".")
        local visual_position = vim.fn.getpos("v")

        local start_row = math.min(cursor_position[2], visual_position[2])
        local end_row = math.max(cursor_position[2], visual_position[2])
        local start_col = math.min(cursor_position[3], visual_position[3])
        local end_col = math.max(cursor_position[3], visual_position[3])

        selected_text = vim.api.nvim_buf_get_text(vim.api.nvim_get_current_buf(), start_row - 1,
                                                  start_col - 1, end_row - 1, end_col, {})[1]
    end

    rgflow.open(selected_text, nil, nil)
end

vim.keymap.set("n", " ", function() end)
vim.keymap.set("n", "<c-p>", ":GFiles --cached --others --exclude-standard<CR>")
vim.keymap.set("n", "<leader>a<c-p>", ":Files<CR>")
vim.keymap.set("n", "<c-b>", ":Buffers<CR>")
vim.keymap.set({"n", "v"}, "<c-f>", open_rgflow_with_optional_visual_selection)
vim.keymap.set("n", "<leader>nt", ":NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>")
vim.keymap.set("n", "<leader>nf", ":NERDTreeFind<CR>:NERDTreeRefreshRoot<CR>")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "<leader>ww", function() vim.cmd([[set wrap!]]) end)
vim.keymap.set("v", "<leader>ss", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]])
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
vim.keymap.set("v", "<leader>hs",
               function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
vim.keymap.set("v", "<leader>hr",
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
