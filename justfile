rebuild:
  sudo darwin-rebuild switch --flake .#$(scutil --get LocalHostName) --show-trace

gc:
  nix-store --gc
  nix-store --optimise
