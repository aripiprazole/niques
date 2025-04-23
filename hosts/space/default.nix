{ pkgs, lib, ... }:
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
  in {
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
        "spotify"

        # System applications
        "eqmac"
        "amethyst"
        "docker"
        "obsidian"
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
