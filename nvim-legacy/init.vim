" -------------------------------------------------------
" colorscheme
" -------------------------------------------------------
runtime gruvbox.vim
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
" If Vim version is equal to or greater than 7.3 enable undo file.
" This allows you to undo changes to a file even after saving it.
" -------------------------------------------------------
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" -------------------------------------------------------
" mappings
" -------------------------------------------------------
" filemanager
noremap <F3> :Lexplore<CR>
" back to normal mode
inoremap jk <Esc>
inoremap kj <Esc>
" number
noremap <F5> :set number! relativenumber!<CR>
" tab visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Move to window
noremap <C-Left> <cmd>wincmd h<cr>
noremap <C-Down> <cmd>wincmd j<cr>
noremap <C-Up> <cmd>wincmd k<cr>
noremap <C-Right> <cmd>wincmd l<cr>
" Resize window
noremap <C-S-Up> <cmd>resize +2<cr>
noremap <C-S-Down> <cmd>resize -2<cr>
noremap <C-S-Left> <cmd>vertical resize -2<cr>
noremap <C-S-Right> <cmd>vertical resize +2<cr>
" buffers
noremap <S-Left> <cmd>bprevious<cr>
noremap <S-Right> <cmd>bnext<cr>
" Clear search with <esc>
noremap <esc> <cmd>noh<cr><esc>


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
set mouse=a
