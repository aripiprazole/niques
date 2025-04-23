{ pkgs, lib, ... }:
  let
    stripJsonComments = path: let
      raw = builtins.readFile path;

      # 1. Remove //… comments by splitting each line on "//" and taking the first part
      lines = lib.strings.splitString "\n" raw;
      noLineComments = builtins.concatStringsSep "\n"
        (builtins.map
          (line: if let trimmed = lib.strings.trim line; in builtins.stringLength trimmed >= 2 && lib.strings.substring 0 2 trimmed == "//"
            then "\n"
            else line)
          lines);

      # 2. Drop trailing commas before } or ] (handles ";\n}" and ";\n]")
      cleaned = builtins.replaceStrings
        [ ";\n}" ";\n]" ]
        [ "\n}"  "\n]" ]
        noLineComments;
      in cleaned;
  in {
    programs.vscode = {
      enable = true;
      profiles = {
        default = {
          extensions = with pkgs.vscode-marketplace; [
            vscodevim.vim
            usernamehw.errorlens
            rust-lang.rust-analyzer
            chadalen.vscode-jetbrains-icon-theme
            ms-vscode-remote.remote-ssh
            mkhl.direnv
            dbaeumer.vscode-eslint
            github.github-vscode-theme
            leanprover.lean4
            ocamllabs.ocaml-platform
            paperproof.paperproof
            wakatime.vscode-wakatime
            haskell.haskell
            tamasfe.even-better-toml
            fill-labs.dependi
          ];
          keybindings = import ./vscode/keybindings.nix;
          userSettings = builtins.fromJSON (stripJsonComments ./vscode/settings.json);
        };
      };
    };
  }
