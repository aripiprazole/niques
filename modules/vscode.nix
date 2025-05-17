{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    # extensions = with pkgs.vscode-marketplace; [
    #   vscodevim.vim
    #   usernamehw.errorlens
    #   rust-lang.rust-analyzer
    #   chadalen.vscode-jetbrains-icon-theme
    #   ms-vscode-remote.remote-ssh
    #   mkhl.direnv
    #   dbaeumer.vscode-eslint
    #   github.github-vscode-theme
    #   leanprover.lean4
    #   ocamllabs.ocaml-platform
    #   paperproof.paperproof
    #   wakatime.vscode-wakatime
    #   haskell.haskell
    #   tamasfe.even-better-toml
    #   fill-labs.dependi
    # ];
    keybindings = import ./vscode/keybindings.nix;
    userSettings = import ./vscode/settings.nix;
  };
}
