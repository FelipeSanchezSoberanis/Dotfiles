set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set nowrap
set relativenumber
set hidden
set noerrorbells
set nu
set scrolloff=10
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set signcolumn=yes
set colorcolumn=80
set numberwidth=1
set mouse=a
set encoding=UTF-8
set cursorline
set completeopt=menu,menuone
set nrformats+=alpha
set diffopt+=vertical
set linebreak

call plug#begin('~/.nvim/plugged')

Plug 'lifepillar/vim-gruvbox8'
Plug 'sickill/vim-monokai'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'lervag/vimtex'
Plug 'andweeb/presence.nvim'
Plug 'tpope/vim-fugitive'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align'
Plug 'sbdchd/neoformat'
Plug 'mzlogin/vim-markdown-toc'
Plug 'lewis6991/spellsitter.nvim'

call plug#end()

" =============================================================================
" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"html"},
    additional_vim_regex_highlighting = false,
  },
}
EOF
" =============================================================================

" =============================================================================
" LSP configs
lua << EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'jdtls', 'texlab', 'emmet_ls', 'html', 'cssls', 'tsserver', 'jsonls', 'yamlls', 'clangd', 'lemminx', 'vuels' }
for _, lsp in ipairs(servers) do
    if (lsp == 'jdtls')
    then
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        cmd = { 'jdtls' }
      }
    elseif (lsp == 'html' or lsp == 'cssls' or lsp == 'jsonls')
    then
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        },
        capabilities = capabilities
      }
    else
      nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
end
EOF
" =============================================================================

" Space as leader
let mapleader=" "
nnoremap <SPACE> <Nop>

let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"

" Gruvbox color theme
colorscheme gruvbox8
let g:gruvbox8_contrast_dark="hard"
let g:gruvbox8_termcolors=256

" Python syntax highlighting
let g:python_highlight_all = 1

" No background color
highlight Normal guibg=None

" Color column grey
highlight ColorColumn guibg=grey

" Trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Airline
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#branch#enabled = 1

" NerdCommenter
let g:NERDSpaceDelims = 1

" Vimtex
let g:vimtex_syntax_conceal_disable = 1
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'

" Bracey
let g:bracey_refresh_on_save=1

" Latex show table of contents
autocmd FileType tex,latex nnoremap <buffer> <leader>toc :VimtexTocToggle<CR>

" Markdown preview
autocmd FileType markdown nnoremap <buffer> <leader>mp :MarkdownPreview<CR>

" HTML preview with Bracey
autocmd FileType html nnoremap <buffer> <leader>hp :Bracey<CR>

" HTML formatter
autocmd FileType html setlocal shiftwidth=2
autocmd FileType html setlocal tabstop=2
autocmd FileType html setlocal softtabstop=2
autocmd FileType html nnoremap <buffer> <leader>ff :Neoformat<CR>

" Vue formatter
autocmd FileType vue setlocal shiftwidth=2
autocmd FileType vue setlocal tabstop=2
autocmd FileType vue setlocal softtabstop=2
autocmd FileType vue nnoremap <buffer> <leader>ff :Neoformat<CR>

" JSON spacing
autocmd FileType json setlocal shiftwidth=2
autocmd FileType json setlocal tabstop=2
autocmd FileType json setlocal softtabstop=2

" CSS formatter
autocmd FileType css nnoremap <buffer> <leader>ff :Neoformat<CR>

" Latex wordcount
autocmd FileType tex,latex nnoremap <buffer> <leader>wc :!detex % \| wc -w<CR>

" Toggle nerdtree
nnoremap <leader>nt :NERDTreeToggle<CR>

" Search filename in working directory
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>a<C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>

" Move between buffers
nnoremap <leader>nb :bnext<CR>
nnoremap <leader>pb :bprevious<CR>

" Coc commands
nnoremap <leader>cda :CocAction<CR>
nnoremap <leader>cdd :CocDiagnostics<CR>

" Word wrapping
nnoremap <leader>ww :set wrap!<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Move in LSP suggestions
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Select pasted text
nnoremap <expr> <leader>sp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Search selected text
vnoremap <leader>ss y/<C-r>"<CR>

" Change conceal level
nnoremap <leader>cl1 :set conceallevel=1<CR>
nnoremap <leader>cl0 :set conceallevel=0<CR>

" Find TODOs
nnoremap <leader>ft /\VTODO<CR>

" Find placeholders
nnoremap <leader>fp /\V<++><CR>

" Center after search
nnoremap n nzz
nnoremap N Nzz

" specify browser to open Markdown preview
let g:mkdp_browser = 'firefox'

" Neoformat use
let g:neoformat_try_node_exe = 1

" Activate spell sitter
lua << EOF
    require('spellsitter').setup()
EOF

