" -------------------------------------------------------
" vim-plug
" -------------------------------------------------------
" install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

" plugin list
call plug#begin()
    Plug 'alec-gibson/nvim-tetris'
    Plug 'davidhalter/jedi-vim'
    Plug 'mhinz/vim-startify'
    Plug 'morhetz/gruvbox'
    Plug 'tpope/vim-vinegar' " netrw cheatsheet: https://gist.github.com/seanh/3c32f6d4f1e27669c4d8a1d3ce3c215b
    Plug 'preservim/tagbar'
    Plug 'vim-airline/vim-airline'
call plug#end()

" -------------------------------------------------------
" colorscheme
" -------------------------------------------------------
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support " (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    " For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    " Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" -------------------------------------------------------
" filebrowser
" -------------------------------------------------------
" netrw toggle
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
let g:netrw_liststyle=3 " tree-style
let g:netrw_winsize = 25 " 25% of window

" -------------------------------------------------------
" airline
" -------------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" -------------------------------------------------------
" mappings
" -------------------------------------------------------
noremap <F2> :TagbarToggle<CR>
noremap <F3> :Lexplore<CR>
" python run
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

command! -nargs=* T belowright split | resize 15 | term <args>

" -------------------------------------------------------
" other settings
" -------------------------------------------------------
syntax on
set encoding=utf-8
set number relativenumber
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set showmode
set laststatus=2
set fillchars+=eob:\ 
set shell=fish
set mouse=a
