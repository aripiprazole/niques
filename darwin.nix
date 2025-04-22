{ pkgs, lib, inputs, ... }:
  let
    entries = [
      { path = "/Applications/Finder.app"; }
      { path = "/Applications/Arc.app"; }
      { path = "/Applications/Calendar.app"; }
      { path = "/Applications/Mail.app"; }
      { path = "/Applications/Messages.app"; }
      { path = "/Applications/WhatsApp.app"; }
      { path = "/Applications/Telegram.app"; }
      { path = "/Applications/Slack.app"; }
      { path = "/Applications/Nix Apps/Spotify.app"; }
    ];
    normalize = path: if lib.hasSuffix ".app" path then path + "/" else path;
    entry_uri = path: "file://" + (builtins.replaceStrings
      [" "   "!"   "\""  "#"   "$"   "%"   "&"   "'"   "("   ")"]
      ["%20" "%21" "%22" "%23" "%24" "%25" "%26" "%27" "%28" "%29"]
      (normalize path)
    );
    want_uris = lib.concatMapStrings (entry: "${entry_uri entry.path}\n") entries;
    create_entries = lib.concatMapStrings
      (entry: "${pkgs.dockutil}/bin/dockutil --no-restart --add '${entry.path}'\n")
      entries;
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
    nix.extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages =
      [ qemu
        pkgs.vim
        pkgs.mkalias
        pkgs.rsync
        pkgs.pinentry_mac
        pkgs.neofetch
        pkgs.raycast
        pkgs.betterdisplay
        pkgs.xz
        pkgs.starship
        pkgs.zsh-autosuggestions
        pkgs.zsh-syntax-highlighting
        pkgs._1password-gui
        pkgs._1password-cli
        pkgs.dockutil
        pkgs.coreutils
      ];

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Enable alternative shell support in nix-darwin.
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      enableSyntaxHighlighting = true;
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

    # Fonts
    fonts.packages = with pkgs; [
      recursive
      nerd-fonts.jetbrains-mono
    ];

    # Set Git commit hash for darwin-version.
    system.configurationRevision = lib.rev or lib.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    system.activationScripts.postUserActivation.text = ''
      echo >&2 "Setting up the Dock..."
      have_uris="$(${pkgs.dockutil}/bin/dockutil --list | ${pkgs.coreutils}/bin/cut -f2)"
      if ! diff -wu <(echo -n "$have_uris") <(echo -n '${want_uris}') >&2 ; then
        echo >&2 "Resetting Dock."
        ${pkgs.dockutil}/bin/dockutil --no-restart --remove all
        ${create_entries}
        killall Dock
      else
        echo >&2 "Dock setup complete."
      fi

      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    # Homebrew for packages not on Nix
    homebrew = {
      enable = true;
      casks = [
        # Real-world stuff
        "arc"
        "whatsapp"
        "telegram"
        "microsoft-teams"
        "spotify"

        # System applications
        "eqmac"
        "amethyst"
        "docker"
        "obsidian"
        "lm-studio"
        "logi-options+"

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

    # Add ability to used TouchID for sudo authentication
    security.pam.services.sudo_local.touchIdAuth = true;

    environment.shellAliases.zed = "zeditor";

    # Keyboard
    system.keyboard.enableKeyMapping = true;
    system.keyboard.remapCapsLockToEscape = true;

    system.defaults.CustomUserPreferences = {
      NSGlobalDomain = {
        WebKitDeveloperExtras = true;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
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
        GloballyEnabled = true;
      };
    };
  }
