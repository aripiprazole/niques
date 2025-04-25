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
        normal = "JetBrainsMonoNF-Regular 17";
        nonAscii = "JetBrainsMonoNF-Regular 11";
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
