{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        mouse = true;
        end-of-line-diagnostics = "error";
        clipboard-provider = "pasteboard";
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
      keys.normal = {
        tab = "move_parent_node_end";
        "S-tab" = "move_parent_node_start";
      };
      keys.insert = {
        "S-tab" = "move_parent_node_start";
      };
      keys.select = {
        tab = "extend_parent_node_end";
        "S-tab" = "extend_parent_node_start";
      };
    };
  };
}
