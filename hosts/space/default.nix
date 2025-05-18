{ pkgs, ... }: {
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix-homebrew.user = "Gabrielle";

  users.users.Gabrielle = {
    home = "/Users/Gabrielle";
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
    PATH = "$PATH:/Users/Gabrielle/.cargo/bin";
  };

  local.dock.enable = true;
  local.dock.entries = [
      { path = "/Applications/SigmaOS.app"; }
      { path = "/System/Applications/Calendar.app"; }
      { path = "/System/Applications/Mail.app"; }
      { path = "/System/Applications/Messages.app"; }
      { path = "/Applications/WhatsApp.app"; }
      { path = "/Applications/Telegram.app"; }
      { path = "/Applications/Discord.app"; }
      { path = "${pkgs.slack}/Applications/Slack.app"; }
      { path = "/Applications/Obsidian.app"; }
      { path = "/Applications/Ghostty.app"; }
      { path = "${pkgs.zed-editor}/Applications/Zed.app"; }
      { path = "/Applications/Spotify.app"; }
    ];

  # Homebrew for packages not on Nix
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "llvm"
    ];
    casks = [
      # Real-world stuff
      "sigmaos"
      "whatsapp"
      "telegram"
      "spotify"

      # System applications
      "eqmac"
      "docker"
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
    caskArgs = {
      appdir = "/Applications";
    };
  };
}
