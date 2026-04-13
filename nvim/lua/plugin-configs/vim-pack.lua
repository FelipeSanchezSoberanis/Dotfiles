local function github(repo) return "https://github.com/" .. repo end

vim.pack.add({
    github("neovim/nvim-lspconfig"), --
    github("hrsh7th/cmp-nvim-lsp"), --
    github("hrsh7th/cmp-buffer"), --
    github("hrsh7th/cmp-path"), --
    github("hrsh7th/cmp-cmdline"), --
    github("hrsh7th/nvim-cmp"), --
    github("b0o/schemastore.nvim"), --
    github("nvim-treesitter/nvim-treesitter"), --
    github("nvim-treesitter/nvim-treesitter-context"), --
    github("windwp/nvim-autopairs"), --
    github("junegunn/fzf"), -- ,
    github("junegunn/fzf.vim"), -- ,
    github("preservim/nerdtree"), -- ,
    github("ryanoasis/vim-devicons"), -- ,
    github("lewis6991/gitsigns.nvim"), -- ,
    {src = github("catppuccin/nvim"), name = "catppuccin", data = {priority = 1000}}, --
    github("tpope/vim-surround"), --
    github("tpope/vim-fugitive"), --
    github("mfussenegger/nvim-jdtls"), --
    github("preservim/nerdcommenter"), --
    github("mangelozzi/rgflow.nvim"), --
    github("nvim-tree/nvim-web-devicons"), --
    github("nvim-lualine/lualine.nvim"), --
    github("stevearc/aerial.nvim"), --
    github("lukas-reineke/indent-blankline.nvim") --
})
