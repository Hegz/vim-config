set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Map leader to space
let mapleader = "\<Space>"

" Tab options
" Set visible tab characters
set list
set lcs=tab:\|\-
set smartindent
set tabstop=4
set shiftwidth=4

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Set PEP8 for Python files
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Flag extranious whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Enable UTF-8 Support
set encoding=utf-8

" Options for YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Options for NERDTree
map <F2> :NERDTreeToggle<CR>

" Syntastic Problem location list
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5

" Paste mode
set pastetoggle=<F8>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1
syntax on

if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif

if has("autocmd")
	" Restore cursor position and set line
	autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
		" autocmd WinEnter * setlocal cursorline
		" autocmd WinLeave * setlocal nocursorline
		" Help file tweaks
		autocmd FileType helpfile set nonumber	" no line numbers when viewing help
		autocmd FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
		autocmd FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

		filetype on

		" Execute on write
		autocmd BufWritePost   *.sh             !chmod +x %
		autocmd BufWritePost   *.pl             !chmod +x %
		autocmd BufWritePost   *.py             !chmod +x %

		autocmd FileType make,cpp,c,java setlocal nospell
		autocmd FileType python,ruby,php,lua,yaml setlocal nospell
		autocmd FileType html,css,js,sql setlocal nospell
		autocmd FileType conf,sh,pl setlocal nospell

endif

" Powerline
set laststatus=2
let Powerline_symbols = 'unicode'
