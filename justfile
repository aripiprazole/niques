rebuild SYSTEM:
  darwin-rebuild switch --flake .#{{SYSTEM}}
  nix-store --gc
  nix-store --optimise
