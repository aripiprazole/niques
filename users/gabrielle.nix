{ pkgs, ... }:
  {
    home.homeDirectory = "/Users/Gabrielle";
    home.stateVersion = "22.05";

    imports = [../pkg];

    programs = {
      home-manager.enable = true;
      command-not-found.enable = false;

      # Direnv, load and unload environment variables depending on the current directory.
      # https://direnv.net
      # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
      direnv.enable = true;
      direnv.nix-direnv.enable = true;

      btop.enable = true;
      btop.settings.vim_keys = true;
    };

    home.file.".amethyst.conf" = {
      enable = true;
      source = ./.amethyst.yml;
    };

    home.packages = with pkgs; [
      # DX
      wakatime-cli
      ngrok
      just
      jq
      fd
      ffmpeg
      direnv
      cmake
      git
      tig
      fzf

      # Text editors
      zed-editor
      vscode
      helix
      iterm2
      obsidian

      # Languages and version managers
      yarn
      opam
      nodejs
      stack
      cabal-install
      elan
      dune-release

      # Language Servers and formatters for DX
      nil
      cmake-language-server
      awk-language-server
      cmake-lint
      nixfmt-classic

      # Messaging
      telegram-desktop
      slack
      discord
    ];

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  }
