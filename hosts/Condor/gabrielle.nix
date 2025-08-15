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
    PATH = "/Users/gabrielle/.local/bin:$PATH";
  };
}
