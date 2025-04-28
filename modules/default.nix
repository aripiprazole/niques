{ pkgs, ... }: {
  imports = [
    ./zed.nix
    ./helix.nix
    ./git.nix
    ./vscode.nix
    ./zsh.nix
  ];

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
    starship
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    any-nix-shell

    # Text editors
    zed-editor
    vscode
    helix
    iterm2

    # Languages and version managers
    nodejs
    yarn
    rustc
    cargo

    # Language DX
    rustPackages.rustfmt
    rustPackages.clippy

    # Messaging
    telegram-desktop
    slack
    discord
  ];

  home.file.".amethyst.yml" = {
    enable = true;
    source = ./amethyst/.amethyst.yml;
  };

  home.file.".config/1Password/ssh/agent.toml" = {
    enable = true;
    source = ./1password/ssh/agent.toml;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
