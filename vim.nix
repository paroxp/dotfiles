{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      "" Encoding
      set encoding=utf-8
      set fileencoding=utf-8
      set fileencodings=utf-8

      "" Fix backspace indent
      set backspace=indent,eol,start

      "" Searching
      set hlsearch
      set incsearch
      set ignorecase
      set smartcase

      " Search mappings: These will make it so that going to the next one in a
      " search will center on the line it's found in.
      nnoremap n nzzzv
      nnoremap N Nzzzv

      set fileformats=unix,dos,mac

      syntax on
      set ruler
      set number

      let no_buffers_menu=1

      "" Disable the blinking cursor.
      set gcr=a:blinkon0

      au TermEnter * setlocal scrolloff=0
      au TermLeave * setlocal scrolloff=3


      "" Status bar
      set laststatus=2

      "" Use modeline overrides
      set modeline
      set modelines=10

      set title
      set titleold="Terminal"
      set titlestring=%F

      set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

      "" no one is really happy until you have this shortcuts
      cnoreabbrev W! w!
      cnoreabbrev Q! q!
      cnoreabbrev Qall! qall!
      cnoreabbrev Wq wq
      cnoreabbrev Wa wa
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq
      cnoreabbrev W w
      cnoreabbrev Q q
      cnoreabbrev Qall qall

      "" Tabs
      nnoremap <Tab> gt
      nnoremap <S-Tab> gT
      nnoremap <silent> <S-t> :tabnew<CR>
    '';

    plugins = with pkgs.vimPlugins; [
      { plugin = nerdtree; config = ''
        let g:NERDTreeChDirMode=2
        let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
        let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
        let g:NERDTreeShowBookmarks=1
        let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
        let g:NERDTreeWinSize = 50
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
        nnoremap <silent> <F2> :NERDTreeFind<CR>
        nnoremap <silent> <F3> :NERDTreeToggle<CR>
      ''; }
      { plugin = vim-nerdtree-tabs; config = "let g:nerdtree_tabs_focus_on_files=1"; }
      { plugin = vim-fugitive; config = ''
        if exists("*fugitive#statusline")
          set statusline+=%{fugitive#statusline()}
        endif
      ''; }
      molokai
      vim-commentary
      vim-gitgutter
      vim-rhubarb
      editorconfig-nvim

      rust-vim
      typescript-vim
      vim-go
      vim-javascript
      vim-jsx-typescript
      vim-nix
      vim-racer
      vim-yaml
    ];
  };
}
