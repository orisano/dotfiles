if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vinarise'

" Syntax plugin
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'Glench/Vim-Jinja2-Syntax'

" Emmet が使えるようになるplugin # <C-y>,
NeoBundle 'mattn/emmet-vim'

" colorscheme solarized を追加するplugin
NeoBundle 'altercation/vim-colors-solarized'
" indent visualize plugin
NeoBundle 'nathanaelkane/vim-indent-guides'
" filetypeごとにtemplate fileを生成できるplugin # ~/.vim/template/template.extension
NeoBundle 'thinca/vim-template'
" 編集中のfileを実行して結果を表示するplugin
NeoBundle 'thinca/vim-quickrun'
" fzf
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }

" Lua interface を用いた code completion plugin
NeoBundle 'Shougo/neocomplete'
" neocomplete に依存したsnippet plugin # <C-k>
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" C++ plugin
" headerにincludeを追加できるplugin # :StargateInclude
NeoBundle 'osyo-manga/vim-stargate'
" C++ code completion plugin
NeoBundle 'justmao945/vim-clang'

" Python plugin
" Python code completion plugin
NeoBundle 'davidhalter/jedi-vim'
" Virtualenv plugin
NeoBundle 'jmcantrell/vim-virtualenv'

" JavaScript plugin
" JS code completion plugin
NeoBundle 'myhere/vim-nodejs-complete'
" JS code formatter
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'einars/js-beautify'

" Erlang
NeoBundle 'vim-erlang/vim-erlang-runtime'
NeoBundle 'vim-erlang/vim-erlang-omnicomplete'
NeoBundle 'vim-erlang/vim-erlang-tags'
NeoBundle 'vim-erlang/vim-erlang-compiler'
NeoBundle 'vim-erlang/erlang-motions.vim'
NeoBundle 'vim-erlang/vim-rebar'
NeoBundle 'vim-erlang/vim-dialyzer'
NeoBundle 'vim-erlang/vim-erlang-skeletons'


call neobundle#end()

filetype plugin indent on
syntax enable

if neobundle#is_installed('vim-clang')
  let g:clang_auto = 0
  let g:clang_cpp_completeopt = 'menuone,preview'
  let g:clang_exec = '/usr/bin/clang'
  let g:clang_cpp_options = '-std=c++11 -I/usr/local/Cellar/gcc5/5.2.0/include/c++/5.2.0/'
  " let g:clang_debug = 5
endif

if neobundle#is_installed('neocomplete')
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_ignore_case = 0
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'scala' : $HOME . '/.vim/dict/scala.dict',
        \ }

  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  inoremap <expr><C-g> neocomplete#undo_completion()
  inoremap <expr><C-l> neocomplete#complete_common_string()

  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  endfunction

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|-\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  let g:neocomplete#force_omni_input_patterns.erlang = '\<[[:digit:][:alnum:]_-]\+:[[:digit:][:alnum:]_-]*'
endif


if neobundle#is_installed('vim-erlang-omnicomplete')
  au FileType erlang setlocal omnifunc=erlang_complete#Complete
endif

if neobundle#is_installed('jedi-vim')
  au FileType python setlocal omnifunc=jedi#completions
  au FileType python setlocal completeopt-=preview
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configration = 0
endif

if neobundle#is_installed('vim-indent-guides')
  let g:indent_guides_start_level=2
  let g:indent_guides_auto_colors=0
  let g:indent_guides_enable_on_vim_startup=0
  let g:indent_guides_color_change_percent=20
  let g:indent_guides_guide_size=1
  let g:indent_guides_space_guides=1
  hi IndentGuidesOdd  ctermbg=235
  hi IndentGuidesEven ctermbg=237
  au FileType coffee,ruby,javascript,python IndentGuidesEnable
endif

if neobundle#is_installed('neosnippet')
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
endif

if neobundle#is_installed('vim-nodejs-complete')
  autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
  let g:node_usejscomplete = 1
endif

if neobundle#is_installed('vim-jsbeautify')
  "autocmd BufWrite,FileWritePre,FileAppendPre *.js call JsBeautify()<cr>
  "autocmd BufWrite,FileWritePre,FileAppendPre *.html :call HtmlBeautify()<cr>
  "autocmd BufWrite,FileWritePre,FileAppendPre *.css call CSSBeautify()<cr>
endif

if executable('clang-format')
  function! s:clang_format()
    let now_line = line(".")
    exec ":%! clang-format"
    exec ":" . now_line
  endfunction
  au BufWrite,FileWritePre,FileAppendPre *.[ch]pp call s:clang_format()
endif

set background=dark
try
  colorscheme solarized
catch
endtry
set encoding=utf-8
set foldmethod=marker

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}][ASCII=\%03.3b][POS=%04l,%04v][%p%%][LEN=%L]

set history=10000
set wildmenu wildmode=list:full

set ignorecase
set infercase
set smartcase
set incsearch
set tabstop=2
set expandtab
set shiftround
set hidden
set switchbuf=useopen
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus,unnamed
else
  set clipboard& clipboard+=unnamed
endif
set nowritebackup
set list
set number
set textwidth=0
set shiftwidth=2
set t_vb=
set novisualbell
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set cursorline
set cursorcolumn

cmap w!! w !sudo tee > /dev/null %
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <C-h> <C-w>h
inoremap <C-l> <C-w>l
