{ config, lib, pkgs, ... }: with lib; let
  cfg = config.programs.iterm2;

  # Convert hex color to iTerm2 color format
  hexToITermColor = hex:
    let
      # Remove the leading '#' if present
      hexColor = lib.strings.removePrefix "#" hex;

      # Hex digit to decimal value mapping
      hexDigits = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
        "A" = 10;
        "B" = 11;
        "C" = 12;
        "D" = 13;
        "E" = 14;
        "F" = 15;
      };

      # Convert two hex digits to decimal
      hexPairToDecimal = hexPair:
        let
          upperDigit = hexDigits.${lib.strings.substring 0 1 hexPair};
          lowerDigit = hexDigits.${lib.strings.substring 1 1 hexPair};
        in (upperDigit * 16 + lowerDigit) / 255.0;

      # Extract and convert RGB components
      r = hexPairToDecimal (lib.strings.substring 0 2 hexColor);
      g = hexPairToDecimal (lib.strings.substring 2 2 hexColor);
      b = hexPairToDecimal (lib.strings.substring 4 2 hexColor);
    in {
      "Alpha Component" = 1;
      "Color Space" = "sRGB";
      "Red Component" = r;
      "Green Component" = g;
      "Blue Component" = b;
    };

  # Profile type for iTerm2 configuration
  profileType = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        description = "Name of the profile.";
      };

      default = mkOption {
        type = types.bool;
        default = false;
        description = "Whether this is the default profile.";
      };

      guid = mkOption {
        type = types.str;
        default = "";
        description =
          "GUID for the profile. If empty, a fixed one will be assigned based on the profile name.";
      };

      command = mkOption {
        type = types.str;
        default = "";
        description = "Command to execute when the profile is launched.";
      };

      colors = {
        background = mkOption {
          type = types.str;
          default = "#000000";
          description = "Background color in hex format.";
        };

        foreground = mkOption {
          type = types.str;
          default = "#ffffff";
          description = "Foreground color in hex format.";
        };

        black = {
          normal = mkOption {
            type = types.str;
            default = "#000000";
            description = "Normal black color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#686868";
            description = "Bright black color in hex format.";
          };
        };

        red = {
          normal = mkOption {
            type = types.str;
            default = "#c91b00";
            description = "Normal red color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#ff6e67";
            description = "Bright red color in hex format.";
          };
        };

        green = {
          normal = mkOption {
            type = types.str;
            default = "#00c200";
            description = "Normal green color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#5ffa68";
            description = "Bright green color in hex format.";
          };
        };

        yellow = {
          normal = mkOption {
            type = types.str;
            default = "#c7c400";
            description = "Normal yellow color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#fffc67";
            description = "Bright yellow color in hex format.";
          };
        };

        blue = {
          normal = mkOption {
            type = types.str;
            default = "#0225c7";
            description = "Normal blue color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#6871ff";
            description = "Bright blue color in hex format.";
          };
        };

        magenta = {
          normal = mkOption {
            type = types.str;
            default = "#ca30c7";
            description = "Normal magenta color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#ff77ff";
            description = "Bright magenta color in hex format.";
          };
        };

        cyan = {
          normal = mkOption {
            type = types.str;
            default = "#00c5c7";
            description = "Normal cyan color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#5ffdff";
            description = "Bright cyan color in hex format.";
          };
        };

        white = {
          normal = mkOption {
            type = types.str;
            default = "#c7c7c7";
            description = "Normal white color in hex format.";
          };

          bright = mkOption {
            type = types.str;
            default = "#ffffff";
            description = "Bright white color in hex format.";
          };
        };
      };

      font = {
        normal = mkOption {
          type = types.str;
          default = "Monaco 12";
          description = "Normal font name and size.";
        };

        nonAscii = mkOption {
          type = types.str;
          default = "Monaco 12";
          description = "Non-ASCII font name and size.";
        };

        useNonAsciiFont = mkOption {
          type = types.bool;
          default = false;
          description =
            "Whether to use a separate font for non-ASCII characters.";
        };

        antiAlias = mkOption {
          type = types.bool;
          default = true;
          description =
            "Whether to use anti-aliasing for the font. Improves readability.";
        };

        brightenBold = mkOption {
          type = types.bool;
          default = false;
          description =
            "Whether to brighten bold text. Makes bold text more visible.";
        };
      };

      cursor = {
        type = mkOption {
          type = types.enum [ "box" "underline" "vertical-bar" ];
          default = "box";
          description = ''
            The cursor shape:
              - box: Standard block cursor (maps to Cursor Type 2 in iTerm2)
              - underline: Thin horizontal line (maps to Cursor Type 0 in iTerm2)
              - vertical-bar: Thin vertical line/I-beam (maps to Cursor Type 1 in iTerm2)
          '';
        };
      };

      terminal = {
        showBellIcon = mkOption {
          type = types.bool;
          default = false;
          description =
            "Whether to show a bell icon in the tab when a bell is rung.";
        };

        visualBell = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to flash the screen when a bell is rung.";
        };

        closeSessionsOnEnd = mkOption {
          type = types.bool;
          default = true;
          description =
            "Whether to close the session when the terminal process exits.";
        };

        warnShortLivedSessions = mkOption {
          type = types.bool;
          default = false;
          description =
            "Whether to warn when closing a session that has lasted a short time.";
        };

        mouseReporting = mkOption {
          type = types.bool;
          default = true;
          description =
            "Whether to enable mouse reporting, allowing terminal applications to receive mouse events.";
        };
      };

      window = {
        columns = mkOption {
          type = types.int;
          default = 80;
          description =
            "Number of columns (characters) in the terminal window.";
        };

        rows = mkOption {
          type = types.int;
          default = 25;
          description = "Number of rows (lines) in the terminal window.";
        };
      };
    };
  };

  # Generate a deterministic GUID from a string
  mkGuid = str:
    let
      # Generate a deterministic hash from the string
      hash = builtins.hashString "sha256" str;
      # Format it as a GUID (8-4-4-4-12)
      guidParts = [
        (lib.strings.substring 0 8 hash)
        (lib.strings.substring 8 4 hash)
        (lib.strings.substring 12 4 hash)
        (lib.strings.substring 16 4 hash)
        (lib.strings.substring 20 12 hash)
      ];
    in concatStringsSep "-" guidParts;

  # Create the iTerm2 plist content
  iTerm2PlistContent = let
    # Process each profile to produce iTerm2 format
    processProfile = profile: {
      "Name" = profile.name;
      "Guid" = if profile.guid != "" then profile.guid else mkGuid profile.name;
      "Normal Font" = profile.font.normal;
      "Non Ascii Font" = profile.font.nonAscii;
      "Use Non-ASCII Font" = if profile.font.useNonAsciiFont then 1 else 0;
      "ASCII Anti Aliased" = if profile.font.antiAlias then 1 else 0;
      "Brighten Bold Text" = if profile.font.brightenBold then 1 else 0;
      "Background Color" = hexToITermColor profile.colors.background;
      "Foreground Color" = hexToITermColor profile.colors.foreground;
      "Ansi 0 Color" = hexToITermColor profile.colors.black.normal;
      "Ansi 8 Color" = hexToITermColor profile.colors.black.bright;
      "Ansi 1 Color" = hexToITermColor profile.colors.red.normal;
      "Ansi 9 Color" = hexToITermColor profile.colors.red.bright;
      "Ansi 2 Color" = hexToITermColor profile.colors.green.normal;
      "Ansi 10 Color" = hexToITermColor profile.colors.green.bright;
      "Ansi 3 Color" = hexToITermColor profile.colors.yellow.normal;
      "Ansi 11 Color" = hexToITermColor profile.colors.yellow.bright;
      "Ansi 4 Color" = hexToITermColor profile.colors.blue.normal;
      "Ansi 12 Color" = hexToITermColor profile.colors.blue.bright;
      "Ansi 5 Color" = hexToITermColor profile.colors.magenta.normal;
      "Ansi 13 Color" = hexToITermColor profile.colors.magenta.bright;
      "Ansi 6 Color" = hexToITermColor profile.colors.cyan.normal;
      "Ansi 14 Color" = hexToITermColor profile.colors.cyan.bright;
      "Ansi 7 Color" = hexToITermColor profile.colors.white.normal;
      "Ansi 15 Color" = hexToITermColor profile.colors.white.bright;
      "Command" =
        if profile.command != "" then profile.command else "/bin/bash";
      # Cursor type: 0 = underline, 1 = vertical bar, 2 = box
      "Cursor Type" = if profile.cursor.type == "box" then
        2
      else if profile.cursor.type == "vertical-bar" then
        1
      else if profile.cursor.type == "underline" then
        0
      else
        2;
      # Terminal settings
      "BM Growl" = if profile.terminal.showBellIcon then 1 else 0;
      "Visual Bell" = if profile.terminal.visualBell then 1 else 0;
      "Close Sessions On End" =
        if profile.terminal.closeSessionsOnEnd then 1 else 0;
      "Prompt Before Closing 2" =
        if profile.terminal.warnShortLivedSessions then 1 else 0;
      "Mouse Reporting" = if profile.terminal.mouseReporting then 1 else 0;

      # Window size
      "Columns" = profile.window.columns;
      "Rows" = profile.window.rows;
    };

    # Process all profiles
    profilesData = map processProfile cfg.profiles;

    # Find the default profile GUID
    getProfileGuid = profile:
      if profile.guid != "" then profile.guid else mkGuid profile.name;
    defaultProfileGuid =
      let defaultProfiles = filter (p: p.default) cfg.profiles;
      in if length defaultProfiles > 0 then
        getProfileGuid (head defaultProfiles)
      else
        "";

    # Theme value mapping
    themeValue = if cfg.settings.appearance.theme == "regular" then
      0
    else if cfg.settings.appearance.theme == "minimal" then
      5
    else if cfg.settings.appearance.theme == "compact" then
      6
    else
      0;

    # Create the plist data structure
    plist = {
      "New Bookmarks" = profilesData;
      "Default Bookmark Guid" = defaultProfileGuid;
      "TabStyleWithAutomaticOption" = themeValue;
    };
  in plist;
in {
  options.programs.iterm2 = {
    enable = mkEnableOption "iTerm2 terminal emulator";

    package = mkOption {
      type = types.package;
      default = pkgs.iterm2;
      description = "The iTerm2 package to use.";
    };

    copyApplications = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to copy iTerm2.app to ~/Applications.";
    };

    copyPrefs = mkOption {
      type = types.bool;
      default = true;
      description =
        "Whether to copy the config to the default iTerm2 preferences location.";
    };

    settings = {
      appearance = {
        theme = mkOption {
          type = types.enum [ "regular" "minimal" "compact" ];
          default = "regular";
          description = "Window theme style.";
        };
      };
    };

    profiles = mkOption {
      type = types.listOf profileType;
      default = [ ];
      description = "List of terminal profiles.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.activation = mkMerge [
      (mkIf cfg.copyApplications {
        copyITerm2ToApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ -d "$HOME/Applications/iTerm2.app" ]; then
            echo "Removing existing iTerm2.app..."
            chmod -R +w "$HOME/Applications/iTerm2.app" || true
            $DRY_RUN_CMD rm -rf "$HOME/Applications/iTerm2.app" || {
              echo "Failed to remove existing iTerm2.app, trying alternative method..."
              $DRY_RUN_CMD find "$HOME/Applications/iTerm2.app" -type f -exec chmod 644 {} \; || true
              $DRY_RUN_CMD find "$HOME/Applications/iTerm2.app" -type d -exec chmod 755 {} \; || true
              $DRY_RUN_CMD rm -rf "$HOME/Applications/iTerm2.app"
            }
          fi

          echo "Copying iTerm2.app to $HOME/Applications..."
          $DRY_RUN_CMD mkdir -p "$HOME/Applications"
          $DRY_RUN_CMD cp -R "${cfg.package}/Applications/iTerm2.app" "$HOME/Applications/iTerm2.app"
        '';
      })

      (mkIf cfg.copyPrefs {
        copyITerm2Preferences = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          # Copy from our managed config to the default iTerm2 preferences location
          PREF_DIR="$HOME/Library/Preferences"
          DEFAULT_PREF="$PREF_DIR/com.googlecode.iterm2.plist"
          MANAGED_PREF="$HOME/.config/iTerm2/com.googlecode.iterm2.plist"

          # Ensure preferences directory exists
          $DRY_RUN_CMD mkdir -p "$PREF_DIR"

          # Make sure iTerm2 is not running to avoid conflicts
          if pgrep -x "iTerm2" > /dev/null; then
            echo "Warning: iTerm2 is currently running. Changes may not take effect until restart."
          fi

          # Backup existing preferences if they exist
          if [ -e "$DEFAULT_PREF" ]; then
            echo "Backing up existing iTerm2 preferences..."
            $DRY_RUN_CMD cp "$DEFAULT_PREF" "$DEFAULT_PREF.backup.$(date +%Y%m%d%H%M%S)"
            # Remove existing preferences file
            $DRY_RUN_CMD rm "$DEFAULT_PREF"
          fi

          # Wait for the managed file to be written
          if [ -e "$MANAGED_PREF" ]; then
            echo "Copying iTerm2 preferences to default location..."
            $DRY_RUN_CMD cp "$MANAGED_PREF" "$DEFAULT_PREF"
            # Ensure proper permissions
            $DRY_RUN_CMD chmod 644 "$DEFAULT_PREF"

            # Kill cfprefsd to force preference reload
            if command -v pkill >/dev/null 2>&1; then
              echo "Reloading preference cache..."
              $DRY_RUN_CMD pkill -f cfprefsd || true
            fi
          else
            echo "Warning: Managed iTerm2 preferences file not found at $MANAGED_PREF"
          fi
        '';
      })
    ];

    xdg.configFile."iTerm2/com.googlecode.iterm2.plist".text = let
      # Convert a Nix value to XML plist representation
      plistValue = v:
        if builtins.isString v then
          "<string>${lib.strings.escape [ "<" ">" "&" ] v}</string>"
        else if builtins.isInt v then
          "<integer>${toString v}</integer>"
        else if builtins.isFloat v then
          "<real>${toString v}</real>"
        else if builtins.isBool v then
          if v then "<true/>" else "<false/>"
        else if builtins.isNull v then
          "<null/>"
        else if builtins.isAttrs v then
          ''
            <dict>
          '' + lib.strings.concatStrings (lib.attrsets.mapAttrsToList (k: val:
            "  <key>${lib.strings.escape [ "<" ">" "&" ] k}</key>\n  ${
                plistValue val
              }\n") v) + "</dict>"
        else if builtins.isList v then
          ''
            <array>
          '' + lib.strings.concatMapStrings (item: "  ${plistValue item}\n") v
          + "</array>"
        else
          throw "Unsupported type for plist conversion";

      plistHeader = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
      '';

      plistFooter = "</plist>";
    in plistHeader + plistValue iTerm2PlistContent + plistFooter;
  };
}
