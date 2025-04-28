{ pkgs, lib, inputs, ... }:
  let
    gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
      gke-gcloud-auth-plugin
    ]);

    python3 = pkgs.python3.withPackages (pkgs: with pkgs; [
      google-cloud-secret-manager
    ]);

    # Work around https://github.com/containers/podman/issues/17026
    # by downgrading to qemu-8.1.3.
    inherit (import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "4db6d0ab3a62ea7149386a40eb23d1bd4f508e6e";
      sha256 = "sha256-kyw7744auSe+BdkLwFGyGbOHqxdE3p2hO6cw7KRLflw=";
    }) { inherit (pkgs) system; }) qemu;
  in {
    # Enable experimental nix command and flakes
    nix = {
      extraOptions = ''
        auto-optimise-store = true
        experimental-features = nix-command flakes
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      settings = {
        # Necessary for using flakes on this system.
        experimental-features = "nix-command flakes";
        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org/"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
      optimise.automatic = true;
    };

    programs.zsh.enable = true;

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages =
      [ qemu
        gdk
        python3
        pkgs.openssl.dev
        pkgs.pkg-config
        pkgs.vim
        pkgs.mkalias
        pkgs.rsync
        pkgs.pinentry_mac
        pkgs.neofetch
        pkgs.raycast
        pkgs.betterdisplay
        pkgs.xz
        pkgs._1password-gui
        pkgs._1password-cli
        pkgs.dockutil
        pkgs.coreutils
        pkgs.warp-terminal
        pkgs.postman
      ];

    environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

    environment.shellAliases.zed = "zeditor";

    environment.variables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      OPENSSL_NO_VENDOR = "1";
      OPENSSL_DIR = "${pkgs.openssl.dev}";
      OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
      OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    };

    # The platform the configuration will be used on.
    nixpkgs = {
      hostPlatform = "aarch64-darwin";
      config.allowUnfree = true;
      config.allowBroken = true;
      overlays = [
        inputs.nix-vscode-extensions.overlays.default
      ];
    };

    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      autoMigrate = true;
      mutableTaps = false;
    };

    homebrew.onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    # Fonts
    fonts.packages = with pkgs; [
      recursive
      nerd-fonts.jetbrains-mono
    ];

    # Add ability to used TouchID for sudo authentication
    security.pam.services.sudo_local.touchIdAuth = true;

    # Set Git commit hash for darwin-version.
    system.configurationRevision = lib.rev or lib.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    # Keyboard
    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;

    # Troubleshooting: the terminal should have full disk access
    system.defaults.CustomUserPreferences = {
      NSGlobalDomain = {
        WebKitDeveloperExtras = true;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screencapture" = {
        location = "~/Desktop";
        type = "png";
      };
      "com.apple.Safari" = {
        # Privacy: don’t send search queries to Apple
        UniversalSearchEnabled = false;
        SuppressSearchSuggestions = true;
        # Press Tab to highlight each item on a web page
        WebKitTabToLinksPreferenceKey = true;
        ShowFullURLInSmartSearchField = true;
        # Prevent Safari from opening ‘safe’ files automatically after downloading
        AutoOpenSafeDownloads = false;
        ShowFavoritesBar = true;
        IncludeInternalDebugMenu = true;
        IncludeDevelopMenu = true;
        WebKitDeveloperExtrasEnabledPreferenceKey = true;
        WebContinuousSpellCheckingEnabled = true;
        WebAutomaticSpellingCorrectionEnabled = false;
        AutoFillFromAddressBook = false;
        AutoFillCreditCardData = false;
        AutoFillMiscellaneousForms = false;
        WarnAboutFraudulentWebsites = true;
        WebKitJavaEnabled = false;
        WebKitJavaScriptCanOpenWindowsAutomatically = false;
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
        "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
      };
      "com.apple.mail" = {
        # Disable inline attachments (just show the icons)
        DisableInlineAttachmentViewing = true;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
      };
      "com.apple.print.PrintingPrefs" = {
        "Quit When Finished" = true;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        ScheduleFrequency = 1;
        AutomaticDownload = 1;
        CriticalUpdateInstall = 1;
      };
      "com.apple.TimeMachine" = {
        DoNotOfferNewDisksForBackup = true;
      };
      "com.apple.ImageCapture" = {
        disableHotPlug = true;
      };
      "com.apple.commerce" = {
        AutoUpdate = true;
      };
    };

    # set some OSX preferences that I always end up hunting down and changing.
    system.defaults = {
      # minimal dock
      dock = {
        autohide = true;
        orientation = "bottom";
        show-process-indicators = true;
        show-recents = false;
        static-only = false;
        expose-group-apps = true;
        magnification = true;
        mineffect = "genie";
        mouse-over-hilite-stack = true;
        showhidden = true;
        mru-spaces = false;
        appswitcher-all-displays = true;
        wvous-tl-corner = 2;  # top-left - Mission Control
      };
      # a finder that tells me what I want to know and lets me work
      finder = {
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        NewWindowTarget = "Home";
        FXEnableExtensionChangeWarning = false;
        FXDefaultSearchScope = "SCcf";
        FXRemoveOldTrashItems = true;
        _FXSortFoldersFirst = true;
        _FXShowPosixPathInTitle = true;
      };
      # Tab between form controls and F-row that behaves as F1-F12
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        "com.apple.keyboard.fnState" = true;
      };
      # Tilling settings
      WindowManager = {
        EnableTiledWindowMargins = true;
        EnableTopTilingByEdgeDrag = true;
        GloballyEnabled = false;
      };
    };
  }
