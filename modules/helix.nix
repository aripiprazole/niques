{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "github_dark";
      editor = {
        line-number = "relative";
        mouse = true;
        end-of-line-diagnostics = "error";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "error";
        };
      };
    };
  };
}
