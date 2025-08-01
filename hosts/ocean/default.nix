{ pkgs, mac-app-util, ... }:
{
  system.primaryUser = "gabrielleoliveira";
  system.activationScripts.activateSettings.text = ''
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
    sharedModules = [ ../../modules ];
    backupFileExtension = "bkp";

    users.gabrielleoliveira = {
      imports = [
        ./gabrielleoliveira.nix
        mac-app-util.homeManagerModules.default
      ];
    };
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Arc.app"; }
    { path = "/System/Applications/Calendar.app"; }
    { path = "/System/Applications/Mail.app"; }
    { path = "/System/Applications/Messages.app"; }
    { path = "/Applications/Spotify.app"; }
    { path = "/Applications/Obsidian.app"; }
  ];

  # Homebrew for packages not on Nix
  homebrew = {
    enable = true;
    caskArgs = {
      appdir = "/Applications";
    };
  };
}
