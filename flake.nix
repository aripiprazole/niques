{
  description = "aripiprazole lab setup";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    git-hooks.url = "github:cachix/git-hooks.nix";
    op-shell-plugins.url = "github:1Password/shell-plugins";
    deploy-rs.url = "github:serokell/deploy-rs";
    tadpole.url = "git+ssh://git@github.com/aripiprazole/niques.tadpole?ref=main";
    tadpole.inputs = { };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      mac-app-util,
      git-hooks,
      op-shell-plugins,
      determinate,
      deploy-rs,
      tadpole,
      ...
    }:
    let
      inherit (nixpkgs.lib) attrValues;
      pkgs-unstable = import inputs.nixpkgs-unstable { system = "aarch64-darwin"; };
      darwinSystem =
        path:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = attrValues self.darwinModules ++ [
            path
            ./darwin.nix
            determinate.darwinModules.default
            mac-app-util.darwinModules.default
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = [
                (_: _: { ruby_4_0 = pkgs-unstable.ruby_4_0; })
              ];
            }
          ];
          specialArgs = {
            homeManagerModule = ./home.nix;
            inherit
              inputs
              mac-app-util
              op-shell-plugins
              ;
          };
        };
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-darwin"
        "aarch64-linux"
      ];
    in
    {
      checks = forAllSystems (system: {
        pre-commit-check = git-hooks.lib.${system}.run {
          src = self;
          hooks = {
            nixfmt.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });

      nixosConfigurations = {
        # Build nix os flake using:
        # $ nixos-rebuild switch --flake .#Hercules
        "Hercules" = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            determinate.nixosModules.default
            ./hercules.nix
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };

      darwinConfigurations = {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Tadpole
        "Tadpole" = darwinSystem tadpole.darwinModules.default;

        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Condor
        "Condor" = darwinSystem ./condor.nix;
      };

      # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
      # fixes.
      darwinModules = {
        programs-nix-index =
          # Additional configuration for `nix-index` to enable `command-not-found` functionality with Fish.
          {
            config,
            lib,
            pkgs,
            ...
          }:
          {
            config = lib.mkIf config.programs.nix-index.enable {
              programs.fish.interactiveShellInit = ''
                function __fish_command_not_found_handler --on-event="fish_command_not_found"
                  ${
                    if config.programs.fish.useBabelfish then
                      ''
                        command_not_found_handle $argv
                      ''
                    else
                      ''
                        ${pkgs.bashInteractive}/bin/bash -c \
                          "source ${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh; command_not_found_handle $argv"
                      ''
                  }
                end
              '';
            };
          };
      };

      deploy.nodes = {
        "Hercules" = {
          hostname = "Hercules";
          profiles.system = {
            user = "root";
            ssh_user = "root";
            path =
              let
                system = "x86_64-linux";
                pkgs = import nixpkgs { inherit system; };
                deployPkgs = import nixpkgs {
                  inherit system;
                  overlays = [
                    deploy-rs.overlay
                    (self: super: {
                      deploy-rs = {
                        inherit (pkgs) deploy-rs;
                        lib = super.deploy-rs.lib;
                      };
                    })
                  ];
                };
              in
              deployPkgs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.Hercules;
          };
        };
      };
    };
}
