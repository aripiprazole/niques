{
  description = "aripiprazole lab setup";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    nixpkgs-nixos.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    git-hooks.url = "github:cachix/git-hooks.nix";
    op-shell-plugins.url = "github:1Password/shell-plugins";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-nixos,
      nix-homebrew,
      home-manager,
      spicetify-nix,
      mac-app-util,
      git-hooks,
      op-shell-plugins,
      determinate,
      ...
    }:
    let
      inherit (nixpkgs.lib) attrValues;
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
            nixfmt-rfc-style.enable = true;
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
        "Hercules" = inputs.nixpkgs-nixos.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            determinate.nixosModules.default
            ./hosts/Hercules/default.nix
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };

      darwinConfigurations =
        let
          pkgs-unstable = import inputs.nixpkgs-unstable {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          default-modules = attrValues self.darwinModules ++ [
            ./hosts/darwin.nix
            mac-app-util.darwinModules.default
            spicetify-nix.darwinModules.spicetify
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
          ];
        in
        {
          # Build darwin flake using:
          # $ darwin-rebuild build --flake .#Tadpole
          "Tadpole" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = default-modules ++ [
              ./hosts/Tadpole/default.nix
            ];
            specialArgs = {
              inherit
                inputs
                pkgs-unstable
                mac-app-util
                op-shell-plugins
                ;
            };
          };

          # Build darwin flake using:
          # $ darwin-rebuild build --flake .#Condor
          "Condor" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = default-modules ++ [
              ./hosts/Condor/default.nix
            ];
            specialArgs = {
              inherit
                inputs
                pkgs-unstable
                mac-app-util
                op-shell-plugins
                ;
            };
          };
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
    };
}
