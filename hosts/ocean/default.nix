{ ... }:
  {
    system.activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    # Homebrew for packages not on Nix
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
      };
      casks = [
        # Real-world stuff
        "arc"
        "whatsapp"
        "telegram"
        "spotify"

        # System applications
        "eqmac"
        "amethyst"
        "docker"
        "obsidian"
        "lm-studio"
        "logi-options+"
        "tailscale"
      ];
      caskArgs = {
        appdir = "/Applications";
      };
    };
  }
