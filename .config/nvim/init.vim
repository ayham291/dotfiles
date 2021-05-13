let mapleader=","
filetype plugin indent on

set title
set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set scrolloff=10
set nowrap
set spell
set spelllang=en_us,de_de
set expandtab
set incsearch
set tabstop=4
set shiftwidth=4
set colorcolumn=100
set cursorline
set cursorcolumn
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
call plug#begin('~/.vim/plugged')

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'gruvbox-community/gruvbox'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-latex/vim-latex'
Plug 'junegunn/goyo.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/AutoComplPop'

call plug#end()


" Some basics:
	nnoremap c "_c
	set nocompatible
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	" set wildmode=longest,list,full

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>x :w! \| !compiler "<c-r>%"<CR><CR>

" Open corresponding .pdf/.html or preview
	map <C-p> :!opout <c-r>%<CR><CR>

    vnoremap <C-c> "+y
    vnoremap <C-f> "+p

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %


    map <leader><F7> :set spell!<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>v<C-w>h
	map <leader>h <C-w>h
	map <C-j> <C-w>v<C-w>j
	map <leader>j <C-w>j
	map <C-k> <C-w>v<C-w>k
	map <leader>k <C-w>k
	map <C-l> <C-w>v<C-w>l
	map <leader>l <C-w>l
    map <C-q> <C-w>q

    nmap <leader><leader> <C-j>
    imap ;; <F5>

    nnoremap ;g :Goyo 100<CR>
    nnoremap ;G :Goyo!<CR>

    let g:Tex_Folding=0

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex


" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>


" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <C-h> :call ToggleHiddenAll()<CR>



colorscheme gruvbox
highlight Normal     ctermbg=NONE guibg=NONE

" This is new style
" call deoplete#custom#var('omni', 'input_patterns', {
"       \ 'tex': g:vimtex#re#deoplete
"       \})


function! s:goyo_leave()
    colorscheme gruvbox
    highlight Normal     ctermbg=NONE guibg=NONE
endfunction


autocmd! User GoyoLeave nested call <SID>goyo_leave()
