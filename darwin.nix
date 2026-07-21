{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ ./dock.nix ];

  nix.enable = false;

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
    config.allowBroken = true;
    overlays = [
    ];
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = [
      pkgs.openssl.dev
      pkgs.pkg-config
      pkgs.vim
      pkgs.mkalias
      pkgs.rsync
      pkgs.pinentry_mac
      pkgs.fastfetch
      pkgs.xz
      pkgs.dockutil
      pkgs.coreutils
      pkgs.fzf
      pkgs.postgresql
      pkgs.flyctl
      pkgs.nixos-rebuild

      # Development utils
      pkgs.zstd.dev
      pkgs.ruby
      pkgs.go
      pkgs.delve
      pkgs.gh
      pkgs.jujutsu
    ];

    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];
    shellAliases.psql = "op plugin run psql --";
    shellAliases.pgcli = "op plugin run pgcli --";
    variables = {
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.ruby}/lib/pkgconfig";
      LIBRARY_PATH = "${pkgs.ruby}/lib:$LIBRARY_PATH";
      DYLD_FALLBACK_LIBRARY_PATH = "${pkgs.ruby}/lib:$DYLD_FALLBACK_LIBRARY_PATH";
      OPENSSL_NO_VENDOR = "1";
      OPENSSL_DIR = "${pkgs.openssl.dev}";
      OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
      OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
      RUST_BACKTRACE = "1";
      EDTIOR = "hx";
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];
    brews = [
      "tailscale"
    ];
    casks = [
      "whatsapp"
      "telegram"
      "spotify"
      "arc"
      "tailscale-app"

      # System applications
      "obsidian"
      "ghostty"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    recursive
    jetbrains-mono
  ];

  # Add ability to used TouchID for sudo authentication
  # security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = lib.rev or lib.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;

    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;

    # Troubleshooting: the terminal should have full disk access
    defaults.CustomUserPreferences = {
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
        ShowFavoritesBar = false;
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
    defaults = {
      dock = {
        autohide = true;
        orientation = "bottom";
        show-process-indicators = true;
        static-only = false;
        expose-group-apps = true;
        magnification = false;
        mineffect = "genie";
        mouse-over-hilite-stack = true;
        showhidden = false;
        mru-spaces = false;
        appswitcher-all-displays = false;
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
        _FXShowPosixPathInTitle = false;
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
        GloballyEnabled = true;
      };
    };
  };
}
