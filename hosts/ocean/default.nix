{ pkgs, ... }: {
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix-homebrew.user = "gabrielleoliveira";

  users.users.gabrielleoliveira = {
    home = "/Users/gabrielleoliveira";
    name = "gabrielleoliveira";
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [../../modules];
    backupFileExtension = "bkp";

    users.gabrielleoliveira = {
      imports = [./gabrielleoliveira.nix];
    };
  };

  environment.variables = {
    PATH = "$PATH:/Users/Gabrielle/.cargo/bin";
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
    { path = "/Applications/Slack.app"; }
    { path = "/Applications/Spotify.app"; }
    { path = "/Applications/Obsidian.app"; }
  ];

  # Homebrew for packages not on Nix
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
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
      "ghostty"
      "obsidian"
      "logi-options+"
      "tailscale"
    ];
    caskArgs = {
      appdir = "/Applications";
    };
  };
}
