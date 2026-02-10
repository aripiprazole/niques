{
  pkgs,
  mac-app-util,
  op-shell-plugins,
  homeManagerModule,
  ...
}:
{
  nix-homebrew.user = "gabrielle";

  system = {
    primaryUser = "gabrielle";
    activationScripts.activateSettings.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  users.users.gabrielle = {
    home = "/Users/gabrielle";
    name = "gabrielle";
    shell = pkgs.zsh;
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Arc.app"; }
    { path = "/System/Applications/Mail.app"; }
    { path = "/Applications/Ghostty.app"; }
    { path = "/${pkgs.zed-editor}/Applications/Zed.app"; }
    { path = "/Applications/Obsidian.app"; }
  ];

  homebrew = {
    brews = [
      "llvm"
      "fftw"
      "qemu"
    ];
    casks = [
      "curseforge"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bkp";

    users.gabrielle = {
      imports = [
        mac-app-util.homeManagerModules.default
        op-shell-plugins.hmModules.default
        homeManagerModule
      ];

      programs.git = {
        settings = {
          user = {
            name = "Gabrielle Oliveira";
            email = "you@gabx.io";
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeK9z5uJU6w1bNKYyUDGlh+wqfws1jJcec83zlolGxp";
          };
          core.sshCommand = "ssh -i ${./condor/ssh/aripiprazole_pub} -o IdentitiesOnly=yes";
        };
      };

      home = {
        homeDirectory = "/Users/gabrielle";
        stateVersion = "25.05";

        packages = with pkgs; [
          livekit
          foreman
        ];

        sessionVariables = {
          PATH = "$PATH:/Users/gabrielle/.radicle/bin/:/Users/gabrielle/.local/bin/";
        };

        file = {
          ".config/1Password/ssh/agent.toml" = {
            enable = true;
            source = ./condor/1password/ssh/agent.toml;
          };
        };
      };
    };
  };
}
