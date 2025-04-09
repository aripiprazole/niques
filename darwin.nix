{ pkgs, lib, inputs, ... }:
{
  # Enable experimental nix command and flakes
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.mkalias
      pkgs.rsync
      pkgs.ollama
      pkgs.raycast
      pkgs.betterdisplay
      pkgs.podman
      pkgs.podman-desktop
      pkgs.podman-compose
      pkgs._1password-gui
      pkgs._1password-cli
    ];

  # Enable common container config files in /etc/containers
  # virtualisation.containers.enable = true;
  # virtualisation = {
  #   podman = {
  #     enable = true;

  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     dockerCompat = true;

  #     # Required for containers under podman-compose to be able to talk to each other.
  #     defaultNetwork.settings.dns_enabled = true;
  #   };
  # };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = lib.rev or lib.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    nerd-fonts.jetbrains-mono
  ];

  # Homebrew for packages not on Nix
  homebrew = {
    enable = true;
    casks = [
      "eqmac"
      "spotify"
      "arc"
    ];
    caskArgs = {
      appdir = "~/Applications";
      require_sha = true;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Configure OLlama service
  # services.ollama = {
  #   enable = true;
  #   loadModels = ["qwen-2.5-coder" "deepseek-r1:1.5b" "llama3.2"];
  # };
  launchd.user.agents.ollama = {
    command = "${pkgs.ollama}/bin/ollama serve";
    environment = {
      OLLAMA_HOST = "127.0.0.1:11434";
    };
    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
    };
  };

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # set some OSX preferences that I always end up hunting down and changing.
  system.defaults = {
    # minimal dock
    dock = {
      autohide = true;
      orientation = "bottom";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    # a finder that tells me what I want to know and lets me work
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    # Tab between form controls and F-row that behaves as F1-F12
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      "com.apple.keyboard.fnState" = true;
    };
  };
}
