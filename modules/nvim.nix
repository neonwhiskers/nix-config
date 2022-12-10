{ pkgs, config, lib, ... }:
with pkgs;
let
  nerdtree = fetchurl {
    url = "https://gitea.tassilo-tanneberger.de/revol-xut/dotfiles/raw/branch/master/config/nvim/plugins/nerdtree.vim";
    sha256 = "sha256-Xq0g2Q6pwKcFtnCieLPx8RLzZ0+93QQgYVEvsUQ8nj8=";
  };
  telescope = fetchurl {
    url = "https://gitea.tassilo-tanneberger.de/revol-xut/dotfiles/raw/branch/master/config/nvim/plugins/telescope.vim";
    sha256 = "sha256-1B1M7Acyj2Fxe8FpYc68FiDuXSnOm1UhyG4Al14vL/w=";
  };
  syntastic = fetchurl {
    url = "https://gitea.tassilo-tanneberger.de/revol-xut/dotfiles/raw/branch/master/config/nvim/plugins/syntastic.vim";
    sha256 = "sha256-tgjofEa/WJsSuQtZj2QMACqQzN2K95AR9O9G+GeqHi0=";
  };

in
{
  # Overlay to use the master build
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      configure = {
        customRC = ''
  '';

        packages.myVimPackage.start = ((with pkgs; [
          tree-sitter
          rust-analyzer
        ]) ++ (with pkgs.vimPlugins; [
          rust-vim
          vim-which-key
          vim-nix
          dracula-vim # dracula colorschema
          palenight-vim # Colorscheme
          nerdtree # File Explorer
          vim-easy-align # Algining code
          lightline-vim
          vim-quickrun
          tagbar # Fancy Bar
          telescope-nvim # Fuzzy Findernvim
          plenary-nvim # Dependency of telescope
          glow-nvim # Markdown commandline renderer
          vimtex
          vim-clang-format # autoformatting with clang
          syntastic # Syntax checking
          vim-move # moving selected block in file
          lingua-franca-vim # syntax highlighting for lingua franca
          vimPlugins.kotlin-vim # syntax for kotlin
          rust-tools-nvim
          nvim-cmp # auto completion
          nvim-lspconfig
          cmp-nvim-lsp
          cmp-vsnip
          cmp-path
          cmp-buffer
          vim-vsnip
        ]));
      };
    };
  };
}
