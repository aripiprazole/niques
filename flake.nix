{
  description = "Gabi many systems configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    #nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
    git-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      spicetify-nix,
      mac-app-util,
      git-hooks,
      ...
    }:
    let
      inherit (nixpkgs.lib) attrValues;
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      supportedSystems = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
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

      darwinConfigurations = {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Ocean
        "Ocean" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = attrValues self.darwinModules ++ [
            ./hosts/darwin.nix
            ./hosts/ocean/default.nix
            mac-app-util.darwinModules.default
            spicetify-nix.darwinModules.spicetify
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
          ];
          specialArgs = {
            inherit inputs pkgs-unstable mac-app-util;
          };
        };

        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#Space
        "Space" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = attrValues self.darwinModules ++ [
            ./hosts/darwin.nix
            ./hosts/space/default.nix
            mac-app-util.darwinModules.default
            spicetify-nix.darwinModules.spicetify
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
          ];
          specialArgs = {
            inherit inputs pkgs-unstable mac-app-util;
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
