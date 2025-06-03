{ config, pkgs, ... }: {
  system.primaryUser = "gabrielle";
  system.activationScripts.activateSettings.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix-homebrew.user = "gabrielle";

  users.users.Gabrielle = {
    home = "/Users/gabrielle";
    name = "Gabrielle";
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [../../modules];
    backupFileExtension = "bkp";

    users.Gabrielle = {
      imports = [./gabrielle.nix];
    };
  };

  environment.variables = {
    PATH = "$PATH:/Users/gabrielle/.cargo/bin";
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Arc.app"; }
    { path = "/System/Applications/Calendar.app"; }
    { path = "/System/Applications/Mail.app"; }
    { path = "/System/Applications/Messages.app"; }
    { path = "/Applications/WhatsApp.app"; }
    { path = "/Applications/Telegram.app"; }
    { path = "/Applications/Discord.app"; }
    { path = "/Applications/Gather.app"; }
    { path = "/Applications/Spotify.app"; }
    { path = "/Applications/Obsidian.app"; }
  ];

  # Homebrew for packages not on Nix
  homebrew = {
    enable = true;
    user = config.system.primaryUser;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "llvm"
      "fftw"
      "colima"
      "docker"
      "docker-compose"
    ];
    casks = [
      # Real-world stuff
      "arc"
      "whatsapp"
      "telegram"
      "spotify"
      "gather"

      # System applications
      "eqmac"
      "obsidian"
      "ghostty"
      "lm-studio"
      "logi-options+"
      "tailscale"

      # Games / Entertainment
      "stremio"
      "whisky"
      "curseforge"
      "modrinth"
    ];
  };
}
