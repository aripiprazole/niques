{ pkgs, ... }:
{
  imports = [
    ./zed.nix
    ./helix.nix
    ./git.nix
    #./vscode.nix
    ./zsh.nix
  ];

  programs = {
    home-manager.enable = true;
    command-not-found.enable = false;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    btop.enable = true;
    btop.settings.vim_keys = true;
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    zoxide.options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
    # DX
    wakatime-cli
    ngrok
    just
    jq
    fd
    ffmpeg
    cmake
    tig
    fzf
    gh
    mkalias

    # Terminal
    starship
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    any-nix-shell
    direnv

    # Language tools
    elan
    rustup
    nixfmt-rfc-style
    nil

    # Text editors
    zed-editor
    vscode
    helix

    # Messaging
    slack
  ];

  home.file."Library/Application Support/com.mitchellh.ghostty/config" = {
    enable = true;
    source = ./ghostty/config;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
