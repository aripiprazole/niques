{ pkgs, ... }: {
  home.homeDirectory = "/Users/Gabrielle";
  home.stateVersion = "22.05";

  imports = [../../modules];

  home.packages = with pkgs; [
    # Programming Languages
    stack
    cabal-install
    elan
    opam
    dune-release

    # DX
    nil
    cmake-language-server
    awk-language-server
    cmake-lint
    nixfmt-classic
  ];
}
