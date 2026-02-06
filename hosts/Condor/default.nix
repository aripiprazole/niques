{
  pkgs,
  mac-app-util,
  op-shell-plugins,
  sharedModules ? [ ],
  ...
}:
{
  system.primaryUser = "gabrielle";
  system.activationScripts.activateSettings.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  nix-homebrew.user = "gabrielle";

  users.users.gabrielle = {
    home = "/Users/gabrielle";
    name = "gabrielle";
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    inherit sharedModules;
    backupFileExtension = "bkp";

    users.gabrielle = {
      imports = [
        ./gabrielle.nix
        mac-app-util.homeManagerModules.default
        op-shell-plugins.hmModules.default
      ];
    };
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Arc.app"; }
    { path = "/System/Applications/Mail.app"; }
    { path = "/Applications/Ghostty.app"; }
    { path = "/${pkgs.zed-editor}/Applications/Zed.app"; }
    { path = "/Applications/Obsidian.app"; }
  ];

  # Homebrew for packages not on Nix
  homebrew = {
    brews = [
      "llvm"
      "fftw"
      "gemini-cli"
      "qemu"
    ];
    casks = [
      "curseforge"
    ];
  };
}
