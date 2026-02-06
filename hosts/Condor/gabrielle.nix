{ pkgs, ... }:
{
  home.homeDirectory = "/Users/gabrielle";
  home.stateVersion = "25.05";

  programs.git.settings.user = {
    name = "Gabrielle Oliveira";
    email = "you@gabx.io";
    signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeK9z5uJU6w1bNKYyUDGlh+wqfws1jJcec83zlolGxp";
  };

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
