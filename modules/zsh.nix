{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    initExtra = ''
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
      OPENSSL_NO_VENDOR = "1";
      OPENSSL_DIR = "${pkgs.openssl.dev}";
      OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
      OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
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
