{
  vim_mode = true;
  tab_size = 2;
  vertical_scroll_margin = 5;
  redact_private_values = true;
  auto_signature_help = true;
  auto_indent_on_paste = false;
  autoscroll_on_clicks = true;
  show_user_picture = true;
  show_completion_documentation = true;
  show_signature_help_after_edits = true;
  use_autoclose = true;
  use_auto_surround = true;
  use_smartcase_search = true;
  buffer_font_size = 18;
  ui_font_size = 18;
  ui_font_family = "JetBrains Mono";
  buffer_font_family = "JetBrains Mono";
  format_on_save = "off";
  scroll_beyond_last_line = "off";
  soft_wrap = "none";
  load_direnv = "shell_hook";
  current_line_highlight = "all";
  # icon_theme = "JetBrains New UI Icons (Dark)";
  wrap_guides = [80 100 120];
  confirm_quit = true;
  preview_tabs = {
    enabled = false;
  };
  slash_commands = {
    docs = {
      enabled = true;
    };
    project = {
      enabled = true;
    };
  };
  agent = {
    version = "2";
    dock = "left";
    enable_feedbacks = false;
    default_model = {
      provider = "anthropic";
      model = "claude-3-7-sonnet-latest";
    };
    editor_model = {
      provider = "openai";
      model = "o3-mini";
    };
  };
  semantic_tokens = {
    enabled = true;
    fetch_debounce_ms = 500;
    edit_debounce_ms = 500;
  };
  session = {
    restore_unsaved_buffers = true;
  };
  chat_panel = {
    dock = "left";
    button = "always";
  };
  debugger = {
    button = true;
  };
  file_finder = {
    modal_max_width = "medium";
  };
  active_pane_modifiers = {
    inactive_opacity = 0.9;
  };
  project_panel = {
    dock = "right";
  };
  outline_panel = {
    dock = "right";
  };
  features = {
    edit_prediction_provider = "zed";
  };
  indent_guides = {
    coloring = "indent_aware";
    background_coloring = "indent_aware";
    active_line_width = 2;
  };
  tab_bar = {
    show_nav_history_buttons = true;
  };
  toolbar = {
    breadcrumbs = false;
    quick_actions = false;
    selections_menu = false;
    agent_review = false;
    code_actions = false;
  };
  tabs = {
    file_icons = true;
    git_status = true;
    show_diagnostics = "all";
  };
  terminal = {
    button = true;
    font_family = "JetBrains Mono";
    scrollbar = {
      show = "auto";
    };
  };
  inlay_hints = {
    enabled = true;
    show_background = false;
  };
  theme = {
    mode = "system";
    dark = "Github Dark";
    light = "Github Light Colorblind";
  };
  vim = {
    toggle_relative_line_numbers = true;
    use_multiline_find = true;
    use_smartcase_find = true;
  };
  diagnostics = {
    use_rendered = true;
    update_with_cursor = true;
    include_warnings = true;
    inline = {
      enabled = true;
      padding = 8;
      min_column = 80;
      update_debounce_ms = 150;
    };
  };
  edit_predictions = {
    mode = "subtle";
    disabled_in = ["comment" "string"];
  };
  languages = {
    Rust = {
      tab_size = 4;
      show_edit_predictions = false;
    };
    TOML = {
      tab_size = 4;
    };
  };
  lsp = {
    nix = {
      binary = {
        path_lookup = true;
      };
    };
    rust-analyzer = {
      binary = {
        path = "/run/current-system/sw/bin/bash";
        arguments = [
          "-c"
          "if [ -e flake.nix ]; then nix develop --command rust-analyzer; else rust-analyzer; fi"
        ];
      };
      initialization_options = {
        checkOnSave = true;
        check.workspace = false;
        hover = {
          actions = {
            references = {
              enable = true;
            };
          };
        };
        # assist.termSearch.enable = true;
        completion = {
          fullFunctionSignatures.enable = true;
        };
      };
    };
    unicode = {
      settings = {
        include_all_symbols = false;
      };
    };
  };
  ssh_connections = [
    {
      host = "213.173.110.211";
      username = "root";
      port = 35023;
      projects = [
        {
          paths = ["/root"];
        }
        {
          paths = ["~/tig-challanges"];
        }
      ];
    }
  ];
}
