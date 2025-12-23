{ ... }:
{
  home.homeDirectory = "/Users/gabrielleoliveira";
  home.stateVersion = "25.05";

  imports = [ ../../modules ];

  home.sessionVariables = {
    PATH = "$PATH:/Users/gabrielleoliveira/go/bin";
  };

  home.file.".config/1Password/ssh/agent.toml" = {
    enable = true;
    source = ./1password/ssh/agent.toml;
  };
}
