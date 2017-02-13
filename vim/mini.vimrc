"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
" filetype plugin on will use the one for python /usr/share/vim/vimxx/ftplugin/python.vim
" autocmd FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4
filetype indent on
filetype indent plugin on
syntax on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
" nmap <leader>w :w!<cr> " used in switch window

" :W sudo saves the file 
" (useful for handling the permission-denied error)
cnoremap w!! w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show line number before a line
set nu

" highlight current line
set cursorline cursorcolumn
hi CursorLine cterm=bold ctermbg=239
hi CursorColumn cterm=bold ctermbg=239
highlight Visual cterm=bold ctermbg=grey

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Height of the command bar
" set cmdheight=2
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

"set clipboard=unnamedplus
set clipboard=unnamed

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set matchtime=2
"""""" It is distracting when showing the matching bracket.
"""""" when you point on a '(' ([,{ is the same), it would first highlight
"""""" ')', while at the same time not hightlighting '(', then after
"""""" a moment, it starts to blink on '('. It seems that there is no good
"""""" solution.  See [1] and [2] for help
"""""" [1] http://vim.1045645.n5.nabble.com/cursor-highlighting-issue-with-matching-brackets-td1172629.html
"""""" [2] https://www.reddit.com/r/vim/comments/2rz74u/question_because_of_matching_parenthesis/
let loaded_matchparen = !has("gui_running") 
" :NoMatchParen 
" :hi MatchParen cterm=NONE ctermbg=cyan ctermfg=black 
" :highlight MatchParen ctermfg=$colour


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
" set tw=78
set wrap
set linebreak
set nolist

set ai "Auto indent
set si "Smart indent
set cin
" c++ access specifier public, private, protected no indent
set cinoptions+=g0

" Default to not read-only in vimdiff
set noro

" switchbuf, use sb to go to a previously open buffer
set swb=usetab

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting/1037182#1037182
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[ map <silent> <Esc> :noh<CR>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
 set laststatus=2

" Format the status line
"  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader> <C-W>
map <leader>f <C-f>
map <leader>b <C-b>
map <leader>d <C-d>
map <leader>u <C-u>
map <leader>e <C-e>
map <leader>y <C-y>

" Other
set sessionoptions+=resize
set sessionoptions+=unix,slash
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" search visual selection instread of the current whole word
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" remember and goto last active buffer
if !exists('g:lasttab')
  let g:lasttab = 1
endif
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" auto paste mode
" https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim/38258720#38258720
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
