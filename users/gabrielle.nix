{ config, pkgs, lib, ... }:
  {
    home.homeDirectory = "/Users/Gabrielle";
    home.stateVersion = "22.05";

    imports = [../pkg];

    programs = {
      home-manager.enable = true;
      command-not-found.enable = false;
    };

    home.packages = with pkgs; [
      wakatime-cli
      pinentry_mac
      direnv
      htop
      ngrok
      just
      jq
      fd
      ffmpeg
      zed-editor
      helix
      git
      _1password-gui
      _1password-cli
    ];

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://github.com/malob/nixpkgs/blob/master/home/default.nix

    # Direnv, load and unload environment variables depending on the current directory.
    # https://direnv.net
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    # Htop
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
    programs.htop.enable = true;
    programs.htop.settings.show_program_path = true;
  }
