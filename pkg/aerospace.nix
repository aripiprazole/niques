{ ... }:
  {
    programs.aerospace = {
      enable = true;
      userSettings = builtins.fromTOML (builtins.readFile ./config.toml);
    };
  };
