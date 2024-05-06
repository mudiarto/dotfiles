echo "Using https://gitub.com/mudiarto/dotfiles config in " . expand('%:p:h')

"
" using vim-plug 
"
" see: https://github.com/junegunn/vim-plug
" neovim - linux installation:
"  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"
" then run nvim
"  :PlugInstall
"
"

"
" NOTE: I collected these over the year, don't remember a lot of it anymore - will try to document it as I go
"       I probably want to change it to lua as well
"

" set config home directory 
let g:dotvim_home=expand('%:p:h')

" Leader
set nocompatible

" use space as leader
let mapleader = " "
" use 'Ctrl-V then <spacebar>' for this?
" let mapleader=" "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
" set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" on pressing tab, insert 2 spaces
set expandtab

" Softtabs, 2 spaces
set tabstop=2
set softtabstop=2

" when indenting with '>', use 2 spaces width
set shiftwidth=2
set shiftround

" Display extra whitespace
" use :nolist to hide it
set list listchars=tab:»·,trail:·,nbsp:·

" Hide signcolumn - extra space on the left
" set signcolumn=no
set signcolumn=auto

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 120 characters is
set textwidth=120
set colorcolumn=+1

" Numbers
set number
set numberwidth=5
" use set nonumber if you want to hide


filetype plugin indent on

" variables
let g:has_async = v:version >= 800 || has('nvim')
let g:is_nvim = has('nvim')

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif


augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json

  " kusno: currently commented since it has issue with ale - maybe because I made ale optional?
  " ALE linting events
  " if g:has_async
  "   set updatetime=1000
  "   let g:ale_lint_on_text_changed = 0
  "   let g:ale_maximum_file_size = 100000
  "   autocmd CursorHold * call ale#Lint()
  "   autocmd CursorHoldI * call ale#Lint()
  "   autocmd InsertEnter * call ale#Lint()
  "   autocmd InsertLeave * call ale#Lint()
  " else
  "   echoerr "The thoughtbot dotfiles require NeoVim or Vim 8"
  " endif
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" kusno: maybe I should use fzf instead
" " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" if executable('ag')
"   " Use Ag over Grep
"   set grepprg=ag\ --nogroup\ --nocolor
"
"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'
"
"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
"
"   if !exists(":Ag")
"     command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
"     nnoremap \ :Ag<SPACE>
"   endif
" endif

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" key mapping
" 
" kusno: most of them are commented, I'll uncomment it as needed later
" inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <S-Tab> <c-n>
"
" " Switch between the last two files
" nnoremap <Leader><Leader> <c-^>
"
" " Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>
"
" " vim-test mappings
" nnoremap <silent> <Leader>t :TestFile<CR>
" nnoremap <silent> <Leader>s :TestNearest<CR>
" nnoremap <silent> <Leader>l :TestLast<CR>
" nnoremap <silent> <Leader>a :TestSuite<CR>
" nnoremap <silent> <Leader>gt :TestVisit<CR>
"
" " Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>
"
" " Treat <li> and <p> tags like the block tags they are
" let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" " Set spellfile to location that is guaranteed to exist, can be symlinked to
" " Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
" set spellfile=$HOME/.vim-spell-en.utf-8.add
"
" " Autocomplete with dictionary words when spell check is on
" set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" kusno: no local config nomore
" " Local config
" if filereadable($HOME . "/.vimrc.local")
"   source ~/.vimrc.local
" endif
"

""********************************************************************************

" vim-plug
" from: https://github.com/junegunn/vim-plug
"
" I'm using this for some plugins that rather difficult to initialize using
" native package manager
"
" install once using:
"
" # for vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" # for neovim
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" then run PlugInstall / PlugUpdate / Plug?
"********************************************************************************

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if g:is_nvim
  let g:plug_dir=stdpath('data') . '/plugged'
else
  let g:plug_dir='~/.vim/plugged'
endif

call plug#begin(g:plug_dir)

" Put plugins here
" Make sure you use single quotes
" type :Plug<tab> to list all plugs command
" use :PlugStatus to check for status
" use :PlugInstall to install new plug
" use :PlugUpdate to update plugins
" use :PlugUpgrade to upgrade vim-plug
"

" fzf stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

" vim ruby
Plug 'vim-ruby/vim-ruby'

" python docstring, require doq
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" language server
Plug 'dense-analysis/ale'

" directory tree
Plug 'preservim/nerdtree'

" status bar for vim
Plug 'vim-airline/vim-airline'

" git tools 
Plug 'tpope/vim-fugitive'

" sensible vim settings
Plug 'tpope/vim-sensible'

" add end, closing }, etc automatically
Plug 'tpope/vim-endwise'

" extended % matching
Plug 'chrisbra/matchit'

" vim tmux integration
Plug 'christoomey/vim-tmux-navigator'

" un/comment code
Plug 'tomtom/tcomment_vim'

" use yankring to store yanked text
Plug 'vim-scripts/YankRing.vim'

" expand
Plug 'terryma/vim-expand-region'

" vim color schemes
Plug 'flazz/vim-colorschemes'

" support editor config
Plug 'editorconfig/editorconfig-vim'

" github-copilot
Plug 'github/copilot.vim'



" unused
" not used: Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoUpdateBinaries' }
" not used: Plug 'nathangrigg/vim-beancount'
" not used: Plug 'kshenoy/vim-signature'



" Initialize plugin system
call plug#end()

" NOTE: this maybe needed if we got issue with file indentation
" see: https://github.com/junegunn/vim-plug/issues/379#issuecomment-191572379
" # uncomment if needed
" filetype indent off 

""********************************************************************************
" kusno local config
"********************************************************************************

" fzf map
noremap <C-p> :Files<CR>

"********************************************************************************
" my favorite settings
"********************************************************************************
set clipboard=unnamedplus
set nowrap

" "********************************************************************************
" " altercation/vim-colors-solarized
" "********************************************************************************
" syntax enable
" set background=light
" colorscheme solarized

" use 24 bit colors in TUI - use esp for Kitty (so far)
set termguicolors

" light theme
" colorscheme solarized8_light_low

" dark theme
" colorscheme solarized8_dark

" default color scheme
colorscheme peachpuff

" "********************************************************************************
" " ack plugin
" "********************************************************************************
" if executable('ag')
"   let g:ackprg = 'ag --vimgrep'
" endif

"********************************************************************************
" NERDTree
" some tips from:
" * https://stackoverflow.com/questions/1979520/auto-open-nerdtree-in-every-tab
"********************************************************************************
"autocmd VimEnter * NERDTree
"autocmd BufWinEnter * NERDTreeMirror

" Open NERDTree in new tabs and windows if no command line args set
" autocmd VimEnter * if !argc() | NERDTree | endif 
" autocmd BufWinEnter * if !argc() | NERDTreeMirror | endif

" NERDTree, Use F3 for toggle NERDTree
" nmap <silent> <F3> :NERDTreeToggle<CR>

"********************************************************************************
" clipboard using file
"********************************************************************************
" leader-y to write latest clipboard to file ~/.vim.clipboard
nnoremap <leader>y :call writefile(split(@@,"\n", 1), '/home/kusno/.vim.clipboard')<CR>
" leader-p to read the file and paste at the current location
nnoremap <leader>p :read /home/kusno/.vim.clipboard<CR>

"********************************************************************************
" large file edit, from:
"   * https://vim.fandom.com/wiki/Faster_loading_of_large_files
"   * http://www.drchip.org/astronaut/vim/index.html#LARGEFILE
"********************************************************************************
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
  au!
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

"********************************************************************************
" my cheatsheet - open with <leader>? - close with :q
"********************************************************************************
nnoremap <leader>? :help cheat-vim<CR>

let g:cheatsheet#cheat_file = '~/.vim/cheat.txt'
if g:is_nvim
  let g:plug_dir=stdpath('data') . '/plugged'
  let g:cheatsheet#float_window = 1
  " you can change float window size.
  let g:cheatsheet#float_window_width_ratio = 0.6
  let g:cheatsheet#float_window_height_ratio = 0.6
endif

" > ""********************************************************************************
" > " my cheatsheet
" > "********************************************************************************
" > command Cheat execute ":help cheat-vim"
" > nnoremap <leader>? :help cheat-vim<CR>
" > " autocmd VimEnter * helptags g:dotvim_home."/doc"
" >
" > " Ctrl-H -> Search - like my intellij
" > " maybe not a good idea tho ..
" > " noremap <Ctrl-H> :Rg
" > nnoremap <leader>gr :Rg<space>

"********************************************************************************
" My FZF mapping
" see: https://github.com/junegunn/fzf.vim
"********************************************************************************

noremap <S-F1> :Helptags<CR>

nnoremap <leader>f: :History:<CR>
nnoremap <leader>f? :Helptags<CR>
nnoremap <leader>f/ :History/<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fm :Maps<CR>
nnoremap <leader>fs :GFiles?<CR>

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

"********************************************************************************
" Yank Ring
"********************************************************************************

nnoremap <leader> :YRShow<CR>

"fix for yankring and neovim
"for error: Clipboard error : Target STRING not available when running
"from: https://github.com/neovim/neovim/issues/2642
let g:yankring_clipboard_monitor=0
