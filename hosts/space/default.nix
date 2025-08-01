{
  pkgs,
  pkgs-unstable,
  mac-app-util,
  ...
}:
{
  system.primaryUser = "gabrielle";
  system.activationScripts.activateSettings.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix-homebrew.user = "gabrielle";

  environment.systemPackages = [ pkgs-unstable.betterdisplay ];

  users.users.gabrielle = {
    home = "/Users/gabrielle";
    name = "gabrielle";
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ../../modules ];
    backupFileExtension = "bkp";

    users.gabrielle = {
      imports = [
        ./gabrielle.nix
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
    { path = "/Applications/WhatsApp.app"; }
    { path = "/Applications/Telegram.app"; }
    { path = "/Applications/Spotify.app"; }
    { path = "/Applications/Obsidian.app"; }
  ];

  # Homebrew for packages not on Nix
  homebrew = {
    enable = true;
    brews = [
      "llvm"
      "fftw"
    ];
    casks = [
      "whisky"
      "curseforge"
    ];
  };
}
