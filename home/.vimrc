" ~/.vimrc - pataccone (configurazione zen)

" --- Base ---
set nocompatible          " Modalità moderna, non compatibile con vi
syntax on                 " Syntax highlighting
set encoding=utf-8        " Encoding UTF-8
set fileencoding=utf-8

" --- Aspetto ---
set number                " Numeri di riga
set relativenumber        " Numeri relativi (utili per navigare)
set cursorline            " Evidenzia riga corrente
set showmatch             " Evidenzia parentesi corrispondente
set scrolloff=8           " Mantieni 8 righe visibili sopra/sotto il cursore
set colorcolumn=80        " Colonna guida a 80 caratteri

" --- Comportamento ---
set hidden                " Permette buffer nascosti senza salvare
set nowrap                " No wrap delle righe lunghe
set backspace=indent,eol,start  " Backspace funziona ovunque

" --- Indentazione ---
set tabstop=4             " Tab = 4 spazi
set shiftwidth=4          " Indentazione = 4 spazi
set expandtab             " Tab diventa spazi
set autoindent            " Indentazione automatica
set smartindent           " Indentazione intelligente

" --- Ricerca ---
set incsearch             " Ricerca incrementale
set hlsearch              " Evidenzia risultati
set ignorecase            " Case insensitive
set smartcase             " Case sensitive se usi maiuscole

" --- Statusline ---
set laststatus=2          " Statusline sempre visibile
set showmode              " Mostra modalità corrente
set showcmd               " Mostra comando in corso
set ruler                 " Posizione cursore in basso a destra

" --- Performance ---
set lazyredraw            " Non ridisegnare durante macro
set ttyfast               " Connessione veloce

" --- Tasto leader ---
let mapleader = " "       " Spazio come leader key

" --- Mappings utili ---
" Salva con leader+w
nnoremap <leader>w :w<CR>
" Chiudi buffer con leader+q
nnoremap <leader>q :q<CR>
" Pulisci highlight ricerca con leader+h
nnoremap <leader>h :nohlsearch<CR>
" Naviga tra split con Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Colori TTY ---
set t_Co=256
colorscheme desert        " Schema colori base, disponibile ovunque
