rebuild:
  sudo darwin-rebuild switch --flake .#$(scutil --get LocalHostName) --show-trace
