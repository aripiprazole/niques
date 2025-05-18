{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, spicetify-nix, ... }:
  let
    inherit (nixpkgs.lib) attrValues optionalAttrs;

    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = "aarch64-darwin";
      config = { allowUnfree = true; allowBroken = true; };
    };
  in {
    # Overlays
    overlays = {
      # Overlays to add various packages into package set
      # Overlay useful on Macs with Apple Silicon
      apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
        # Add access to x86 packages system is running Apple Silicon
        pkgs-x86 = import nixpkgs {
          system = "x86_64-darwin";
          config = { allowUnfree = true; };
        };
      };
    };

    darwinConfigurations = {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Ocean
      "Ocean" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = attrValues self.darwinModules ++ [
          ./hosts/darwin.nix
          ./hosts/ocean/default.nix
          spicetify-nix.darwinModules.spicetify
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
        specialArgs = { inherit inputs pkgs-unstable; };
      };

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Space
      "Space" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = attrValues self.darwinModules ++ [
          ./hosts/darwin.nix
          ./hosts/space/default.nix
          spicetify-nix.darwinModules.spicetify
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
        ];
        specialArgs = { inherit inputs pkgs-unstable; };
      };
    };

    # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
    # fixes.
    darwinModules = {
      programs-nix-index =
        # Additional configuration for `nix-index` to enable `command-not-found` functionality with Fish.
        { config, lib, pkgs, ... }: {
          config = lib.mkIf config.programs.nix-index.enable {
            programs.fish.interactiveShellInit = ''
              function __fish_command_not_found_handler --on-event="fish_command_not_found"
                ${if config.programs.fish.useBabelfish then ''
                command_not_found_handle $argv
                '' else ''
                ${pkgs.bashInteractive}/bin/bash -c \
                  "source ${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh; command_not_found_handle $argv"
                ''}
              end
            '';
          };
        };
    };
  };
}
