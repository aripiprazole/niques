{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      simplified_ui = true;
      theme = "gruvbox-light";
      default_layout = "compact";
      show_startup_tips = false;
      pane_frames = false;
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "[➜](bold green)";
      };
    };
  };
  programs.zsh = {
    enable = true;
    initContent = ''
      PROMPT="$\{PROMPT\}"$'\n'
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    sessionVariables = {
      PATH = "$PATH:${pkgs.python3}/bin";
    };
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
}
