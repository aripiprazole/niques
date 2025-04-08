{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, rust-overlay }:
  let
    inherit (self) outputs;
    inherit (nix-darwin.lib) darwinSystem;
    inherit (nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;
    inherit (home-manager.lib) hm;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in
  {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = true;

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Overlays
    overlays = {
      # Overlays to add various packages into package set
      # Overlay useful on Macs with Apple Silicon
      apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
        # Add access to x86 packages system is running Apple Silicon
        pkgs-x86 = import inputs.nixpkgs-unstable {
          system = "x86_64-darwin";
          config = { allowUnfree = true; };
          overlays = [
            rust-overlay.overlays.default
          ];
        };
      };
    };

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Space" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = attrValues self.darwinModules ++ [
        ./darwin.nix
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [./pkg/default.nix];

            users = {
              Gabrielle = {
                imports = [./users/gabrielle.nix];
              };
            };
          };
          users.users = {
            Gabrielle = {
              home = "/Users/Gabrielle";
            };
          };
        }
      ];
      specialArgs = { inherit inputs; };
    };

    # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream
    # fixes.
    darwinModules = {
      programs-nix-index =
        # Additional configuration for `nix-index` to enable `command-not-found` functionality with Fish.
        { config, lib, pkgs, ... }:
        {
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
