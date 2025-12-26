{
  pkgs,
  mac-app-util,
  op-shell-plugins,
  ...
}:
let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
    ]
  );

  python3 = pkgs.python3.withPackages (
    pkgs: with pkgs; [
      google-cloud-secret-manager
      gdk
      pip
    ]
  );
in
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

  environment.systemPackages = [
    gdk
    python3
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ ../../modules ];
    backupFileExtension = "bkp";

    users.gabrielleoliveira = {
      imports = [
        ./gabrielleoliveira.nix
        op-shell-plugins.hmModules.default
        mac-app-util.homeManagerModules.default
      ];
    };
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Safari.app"; }
    { path = "/System/Applications/Mail.app"; }
    { path = "/${pkgs.slack}/Applications/Slack.app"; }
    { path = "/Applications/Discord.app"; }
    { path = "/Applications/Ghostty.app"; }
    { path = "/${pkgs.zed}/Applications/Zed.app"; }
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
