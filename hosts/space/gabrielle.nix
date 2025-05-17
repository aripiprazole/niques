{ pkgs, ... }: {
  home.homeDirectory = "/Users/Gabrielle";
  home.stateVersion = "22.05";

  imports = [../../modules];

  home.packages = with pkgs; [
    # Dev tools
    livekit
    foreman

    # # Programming Languages
    # elan

    # # DX
    # nil
    # cmake-language-server
    # cmake-lint
    # nixfmt-classic
  ];
}
