{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "wakatime"
      "ocaml"
      "scheme"
      "rust"
      "proto"
      "haskell"
      "zig"
      "elixir"
      "nix"
      "make"
      "toml"
      "html"
      "dockerfile"
      "jetbrains-new-ui-icons"
      "github-theme"
    ];
    userKeymaps = builtins.fromJSON (builtins.readFile ./zed/keymap.json);
    userSettings = import ./zed/settings.nix pkgs;
  };
}
