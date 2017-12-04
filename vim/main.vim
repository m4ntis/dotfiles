" Leave no backwards meh from vi
set nocompatible

" Basic styling options
syntax enable
filetype plugin on
set number
set nowrap

" Make the status line display the name and stuffs
set statusline=%F

" Spaces instead of tabs, <TAB> == 4 spaces
function SetTabs()
  let indent_size = 4
  if &ft == "sh" || &ft == "vim"
    let indent_size = 2
  endif

  let &st=indent_size
  let &sw=indent_size
  let &sts=indent_size

  set expandtab
  set autoindent
endfunction

autocmd BufEnter * call SetTabs()

" Ignore case in search if all in lower, highlight, incremental
set smartcase
set hlsearch
set incsearch

" Remap ; and : for easy command mode shenanigans
nnoremap ; :
nnoremap : ;

" <C-h|j|k|l> to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Add subfolders to vim's path in order to work with one instance of vim open
" in the root of the project, and add go's src too in order to find stuff from
" the source
function SetPath()
  set path=.,,**,
  if &ft == "go"
    set path+=/usr/local/go/src/**,
  elseif &ft == "c" || &ft == "cpp"
    set path+=/usr/include,
  endif
endfunction

autocmd BufEnter * call SetPath()

" Display tab-completion matches in a cool menu thingy
set wildmenu

" Fold by syntax
set fdm=syntax

" Remap <Space> to toggle folds
nnoremap <Space> za

" Uncomment this to use space to fold under cursor till the end instead of one
" level
"nnoremap <Space> zM:echom foldlevel(line('.'))<CR>

" This requires ctags installed
" Map the command 'MakeTags' to generate the tags file for the project
" ^]  - jump to tag
" g^] - jump to ambiguous tag
" ^t  - jump back to tag stack
command! MakeTags !ctags -R .

" Autocomplete documentation is present in |ins-completion|
" Good little things to remember:
" ^n         - display all autocomplete options and scroll down the options list
"              (^p to go back in the options)
" ^x[option] - autocomplete options are based on selective things, such as:
"              ^n - complete from this file only
"              ^f - complete by filenames only
"              ^j - complete by tags

" TODO: Make the snippets be read from like a configurable place instead of the
" user's home dir
" Snippets
nnoremap ,go :-1read $HOME/dotfiles/vim/snippets/skele.go<CR>wa
nnoremap ,sh :-1read $HOME/dotfiles/vim/snippets/skele.sh<CR>2jA
nnoremap ,py :-1read $HOME/dotfiles/vim/snippets/skele.py<CR>4jA
