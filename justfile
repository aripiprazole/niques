rebuild:
  sudo darwin-rebuild switch --flake .#$(scutil --get LocalHostName)
  nix-store --gc
  nix-store --optimise
