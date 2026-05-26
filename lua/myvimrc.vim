" ============================================================================
" myvimrc.vim — personal keybindings ported from VsVim (.vimrc)
" Sourced near the bottom of init.lua so it overrides kickstart's defaults.
" ============================================================================

" ---------- General ----------
" (kickstart already sets number/relativenumber/hlsearch; harmless to repeat)
set number
set relativenumber
set hlsearch

" powershell as default shell
set shell=powershell.exe
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
set shellquote=
set shellxquote=

" thicker, darker window separators
set fillchars+=vert:┃,horiz:━,horizup:┻,horizdown:┳,vertleft:┫,vertright:┣,verthoriz:╋
highlight WinSeparator guifg=#414868 guibg=NONE

" Leader is Space (matches kickstart)
let mapleader = " "

" ---------- Buffer / window navigation ----------
nnoremap th :bprevious<CR>
nnoremap tl :bnext<CR>

" clear search highlight
nnoremap hl :nohlsearch<CR>

" keep cursor centered when jumping to top/bottom of screen
nnoremap H Hzz
nnoremap L Lzz
vnoremap H Hzz
vnoremap L Lzz

" splits (use built-in <C-w>s for horizontal to avoid clashing with kickstart's
" <leader>f = format buffer)
nnoremap <leader>v :vsplit<CR>

" write / quit  (capitalized to avoid kickstart's <leader>q diagnostics list
" and <leader>s search prefix)
nnoremap <leader>w :w!<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>X :x!<CR>

" diagnostics next/prev — native LSP
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR>

" code action (kickstart also binds gra; this keeps your muscle memory)
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" quick open — Telescope find_files
nnoremap ff <cmd>Telescope find_files<CR>

" peek definition — Telescope shows a list/preview window
nnoremap gh <cmd>Telescope lsp_definitions<CR>

" go to definition (LSP default; kickstart enables this)
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>

" navigate back — native jumplist
nnoremap gb <C-o>
vnoremap gb <C-o>

" ---------- Visual mode ----------
" indent / outdent while staying in visual
vnoremap < <gv
vnoremap > >gv

" move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" toggle comment — uses mini.comment's gc/gcc (must use map, not noremap)
vmap <leader>k gc
nmap <leader>k gcc

" ---------- Insert mode ----------
" jk to exit insert
inoremap jk <Esc>

" ---------- Disabled (VS-specific, no nvim equivalent yet) ----------
" PeasyMotion — install flash.nvim if you want jump-anywhere labels:
"   nnoremap t :HopWord<CR>   (or similar with flash.nvim)
