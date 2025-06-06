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
    tig
    fzf
    starship
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    any-nix-shell
    gh
    nixd
    mkalias

    # Language tools
    elan
    rustup

    # Text editors
    zed-editor
    vscode
    helix

    # Messaging
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

  home.file."Library/Application Support/com.mitchellh.ghostty/config" = {
    enable = true;
    source = ./ghostty/config;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
