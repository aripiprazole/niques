{ pkgs, ... }:
{
  home.homeDirectory = "/Users/gabrielle";
  home.stateVersion = "25.05";

  imports = [ ../../modules ];

  home.packages = with pkgs; [
    # Dev tools
    livekit
    foreman
  ];

  home.sessionVariables = {
    PATH = "$PATH:/Users/gabrielle/.radicle/bin/:/Users/gabrielle/.local/bin/";
  };

  home.file.".config/1Password/ssh/agent.toml" = {
    enable = true;
    source = ./1password/ssh/agent.toml;
  };
}
