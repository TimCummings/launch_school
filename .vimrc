" ============================================================
" Vim-Plug
" ============================================================

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
call plug#end()

" ============================================================
" Plugin-Specific Settings
" ============================================================

" required for vim-markdown-preview plugin
let vim_markdown_preview_github=1

" syntax highlighting within code fences of markdown files
let g:vim_markdown_fenced_languages = ['html', 'javascript', 'ruby']

" ============================================================
" Color Scheme Settings
" ============================================================
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost
" $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
"      "For Neovim 0.1.3 and 0.1.4 <
"      https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
" For Neovim > 0.1.5 and Vim > patch 7.4.1799
"   < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" Based on Vim patch 7.4.1770 (`guicolors` option)
"   < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"   < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" enable syntax highlighting
syntax on
set background=dark
colorscheme onedark

" ============================================================
" Other Settings
" ============================================================

" various tab related settings
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
" set smartindent

" show absolute and relative line numbers
set number
set relativenumber

" always show cursor position
" set ruler

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

" status line
set laststatus=2
set noshowmode

" Exclude line numbers when selecting/copying
se mouse+=a
