let mapleader=","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif


set title
set path+=**
set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
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
set completeopt=noselect,menuone
set shortmess+=c
call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-latex/vim-latex'
Plug 'sbdchd/neoformat'
Plug 'junegunn/goyo.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': './install' }
Plug 'haya14busa/incsearch.vim'
Plug 'github/copilot.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'mxw/vim-jsx'

call plug#end()


" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax enable
    let g:tex_flavor = 'latex'
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
    set wildmode=longest,list,full
    set wildmenu
    " Ignore files
    set wildignore+=*.pyc
    set wildignore+=*_build/*
    set wildignore+=**/coverage/*
    set wildignore+=**/node_modules/*
    set wildignore+=**/android/*
    set wildignore+=**/ios/*
    set wildignore+=**/.git/*

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <C-p> :!opout <c-r>%<CR><CR>
    map <C-n> :Neoformat<CR>

    vnoremap <C-c> "+y
    vnoremap <C-f> "+p

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>

    map <leader><F7> :set spell!<CR>

    map <leader>f :FZF<CR>

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
    imap ;ae ä
    imap ;ue ü
    imap ;oe ö
    imap ;ss ß
    imap ;Ae Ä
    imap ;Ue Ü
    imap ;Oe Ö

    " nnoremap ;g :Goyo 100<CR>
    " nnoremap ;G :Goyo!<CR>

    let g:Tex_Folding=0

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex


" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
    autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
	autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
	autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }

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
nnoremap <leader>h :call ToggleHiddenAll()<CR>



colorscheme gruvbox
highlight Normal     ctermbg=NONE guibg=NONE
highlight Comment    ctermbg=Black cterm=italic,bold guibg=NONE

" This is new style
" call deoplete#custom#var('omni', 'input_patterns', {
"       \ 'tex': g:vimtex#re#deoplete
"       \})


function! s:goyo_leave()
    colorscheme gruvbox
    highlight Normal     ctermbg=NONE guibg=NONE
endfunction


autocmd! User GoyoLeave nested call <SID>goyo_leave()

lua require('telescope').setup{defaults={file_sorte = require('telescope.sorters').get_fzy_sorter}}
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({search = vim.fn.input('Search: ')})<CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <C-g> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>pt :lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>



let g:copilot_filetypes = {
      \ 'markdown': v:true,
      \ }

let g:neoformat_tex_latexindent = {
            \ 'exe': 'latexindent',
            \ 'args': ['-w'],
            \ 'replace': 1,
            \ 'no_append': 0,
            \ }
let g:neoformat_try_node_exe = 1
" let g:neoformat_enabled_tex = ['latexindent', 'prettier']
let g:neoformat_enabled = ['latexindent', 'prettier']
let g:prettier#config#tab_width = 2
let g:neoformat_basic_format_tab_width = 2
let g:neoformat_basic_format_indent_size = 2
let g:neoformat_basic_format_use_tabs = 0

" let g:neoformat_verbose = 1 " only affects the verbosity of Neoformat
" lua require('ja')

" This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - Popup window (center of the screen)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - Popup window (center of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" - Popup window (anchored to the bottom of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" - down / up / left / right
" let g:fzf_layout = { 'down': '40%' }

" - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
autocmd FileType tex let b:coc_pairs = [["$", "$<++>"], ["{", "}<++>"], ["[", "]<++>"], ["(", ")<++>"]]

runtime macros/matchit.vim
