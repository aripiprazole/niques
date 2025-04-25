{ ... }: {
  programs.iterm2 = {
    enable = true;
    settings.appearance.theme = "minimal";

    profiles = [{
      name = "nix managed";
      default = true;

      window = {
        columns = 180;
        rows = 50;
      };

      font = {
        normal = "JetBrainsMono-Nerd-Font-Regular 17";
        nonAscii = "JetBrainsMono-Nerd-Font-Regular 17";
        useNonAsciiFont = false;
        antiAlias = true;
        brightenBold = true;
      };

      terminal = {
        mouseReporting = true;
        showBellIcon = true;
        visualBell = true;
        closeSessionsOnEnd = true;
        warnShortLivedSessions = false;
      };
    }];
  };
}
