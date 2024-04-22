local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "iamcco/markdown-preview.nvim", --
    "jiangmiao/auto-pairs", --
    "mfussenegger/nvim-jdtls", --
    "neovim/nvim-lspconfig", --
    "hrsh7th/cmp-nvim-lsp", --
    "hrsh7th/cmp-buffer", --
    "hrsh7th/cmp-path", --
    "hrsh7th/cmp-cmdline", --
    "hrsh7th/nvim-cmp", --
    "SirVer/ultisnips", --
    "quangnguyen30192/cmp-nvim-ultisnips", --
    "honza/vim-snippets", --
    "junegunn/fzf", --
    "junegunn/fzf.vim", --
    "preservim/nerdtree", --
    "Xuyuanp/nerdtree-git-plugin", --
    "vim-airline/vim-airline", --
    "preservim/nerdcommenter", --
    "tpope/vim-surround", --
    "nvim-treesitter/nvim-treesitter", --
    "nvim-treesitter/nvim-treesitter-context", --
    "lewis6991/gitsigns.nvim", --
    "tpope/vim-fugitive", --
    "catppuccin/nvim", --
    "godlygeek/tabular", --
    "preservim/vim-markdown", --
    "mzlogin/vim-markdown-toc", --
    "junegunn/vim-easy-align", --
    "editorconfig/editorconfig-vim", --
    "ryanoasis/vim-devicons", --
    "lukas-reineke/indent-blankline.nvim", --
    {dir = "/home/felipe/Documents/copy-path/main"} --
})
