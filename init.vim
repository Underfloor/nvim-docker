set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

" General Plugins
Plug 'w0ng/vim-hybrid'

Plug 'airblade/vim-gitgutter'

Plug 'wikitopian/hardmode'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'majutsushi/tagbar'

Plug 'nathanaelkane/vim-indent-guides'

" Files Plugins
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'will133/vim-dirdiff'

" Typescript Plugins
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'typescript'] }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mhartington/nvim-typescript', { 'do': './install.sh', 'for': 'typescript' }

" Twig Plugins
Plug 'nelsyeung/twig.vim', { 'for': ['html', 'twig', 'html.twig.js.css'] }
Plug 'chrisbra/Colorizer', { 'for': ['html', 'twig', 'html.twig.js.css', 'css', 'less', 'sass', 'vim'] }

" Kerboscript Plugins
Plug 'yump/vim-kerboscript', { 'for': 'kerboscript' }

" Groovy plugins
Plug 'vim-scripts/groovy.vim', { 'for': 'groovy' }

" Latex Plugins
Plug 'lervag/vimtex', { 'for': 'tex' }

call plug#end()

call neomake#configure#automake('nrwi', 1000)

syntax on
filetype indent plugin on
set noet ci pi sts=0 sw=4 ts=4
set cursorline
colorscheme hybrid
set background=dark
set termguicolors
set colorcolumn=120
set scrolloff=3
set backspace=indent,eol,start

set number relativenumber

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Neomake
let g:neomake_open_list = 2

" Deoplete
let g:deoplete#enable_at_startup = 1
" Deoplete Tab Complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Tagbar
" Tagbar Typescript
let g:tagbar_type_typescript = {
	\ 'ctagsbin': 'tstags',
	\ 'ctagsargs': '-f-',
	\ 'kinds': [
		\ 'e:enums:0:1',
		\ 'f:function:0:1',
		\ 't:typealias:0:1',
		\ 'M:Module:0:1',
		\ 'I:import:0:1',
		\ 'i:interface:0:1',
		\ 'C:class:0:1',
		\ 'm:method:0:1',
		\ 'p:property:0:1',
		\ 'v:variable:0:1',
		\ 'c:const:0:1',
	\ ],
	\ 'sort' : 0
	\ }

" Indentguides
let g:indent_guides_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd	guibg=#303030 ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven	guibg=#262626 ctermbg=235

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'hybrid'

" Hardmode
let g:HardMode_level = 'wannabe'
noremap <Leader>h <Esc>:call ToggleHardMode()<CR>

" NERDTree
noremap <silent> <Leader>e :NERDTreeFind<CR>
noremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowLineNumbers = 1
" NERDTree FileExtensionHighlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" LaTeX
let g:tex_flavor = "latex"

" JsDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_access_descriptions = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_param_description_separator = ' - '
nmap <silent> <C-l> <Plug>(jsdoc)

" Autocmd
autocmd VimEnter * NERDTree | wincmd p
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
autocmd BufWritePre * %s/\s\+$//e
