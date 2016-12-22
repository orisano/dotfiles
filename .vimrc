let $PATH = "~/.pyenv/shims:".$PATH

if &compatible
    set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
call dein#begin("~/.cache/dein")

call dein#add("Shougo/dein.vim")

" completion
call dein#add("Shougo/neocomplete.vim")
call dein#add("davidhalter/jedi-vim", {"on_ft": ["python", "python3"]})
call dein#add("justmao945/vim-clang", {"on_ft": ["c", "cpp"]})

" web
call dein#add("mattn/emmet-vim", {"on_ft": ["html", "css"]})

" python
call dein#add("lambdalisue/vim-pyenv", {"depends": ["jedi-vim"], "merged": 0, "on_ft": ["python", "python3"]})

" misc
call dein#add("thinca/vim-template")

call dein#end()

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

if dein#tap("neocomplete.vim")
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#force_overwrite_completefunc = 1
    let g:neocomplete#sources#min_keyword_length = 3

    if !exists("g:neocomplete#keyword_patterns")
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns["default"] = "\h\w*"
    if !exists("g:neocomplete#force_omni_input_patterns")
        let g:neocomplete#force_omni_input_patterns = {}
    endif
endif

if dein#tap("jedi-vim")
    autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python setlocal completeopt+=noinsert,noselect
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:neocomplete#force_omni_input_patterns.python = "\%([^/ \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*"
endif

if dein#tap("vim-clang")
    let g:clang_auto = 0
    let g:clang_cpp_completeopt = 'menuone,preview,noinsert'
    let g:clang_exec = "/usr/bin/clang"
    let g:clang_cpp_options = '-std=c++11 -I/usr/local/Cellar/gcc/6.2.0/include/c++/6.2.0/ -I/Users/orisano/proj/ -I/usr/local/include/ -Wno-pragma-once-outside-header'
    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endif

set encoding=utf-8

set number
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start
set cursorline

" {{{ }}} で折りたためるようになる
set foldmethod=marker
" clipboard共有に必要
if has("unnamedplus")
    set clipboard& clipboard+=unnamedplus,unnamed
else
    set clipboard& clipboard+=unnamed
endif

" keymap
cmap w!! w !sudo tee > /dev/null %
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-w>h
inoremap <C-l> <C-w>l

if executable("clang-format")
    function! s:clang_format()
        let now_line = line(".")
        exec ":%! clang-format"
        exec ":" . now_line
    endfunction
    au BufWrite,FileWritePre,FileAppendPre *.[ch]pp call s:clang_format()
endif
