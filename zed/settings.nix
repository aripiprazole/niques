pkgs: {
  vim_mode = true;
  tab_size = 2;
  vertical_scroll_margin = 3;
  redact_private_values = true;
  auto_signature_help = true;
  auto_indent_on_paste = false;
  autoscroll_on_clicks = true;
  show_completion_documentation = true;
  show_signature_help_after_edits = true;
  use_autoclose = true;
  use_auto_surround = true;
  use_smartcase_search = true;
  buffer_font_size = 22;
  ui_font_size = 22;
  ui_font_family = ".SystemUIFont";
  buffer_font_family = "JetBrains Mono NL";
  format_on_save = "on";
  autosave = "off";
  scroll_beyond_last_line = "off";
  soft_wrap = "none";
  load_direnv = "shell_hook";
  current_line_highlight = "all";
  wrap_guides = [
    80
    100
    120
  ];
  confirm_quit = true;
  preview_tabs.enabled = true;
  bottom_dock_layout = "contained";
  inlay_hints.enabled = false;
  inlay_hints.toggle_on_modifiers_press.function = true;
  semantic_tokens = "combined";
  telemetry = {
    diagnostics = false;
    metrics = false;
  };
  languages = {
    Rust = {
      tab_size = 4;
      show_edit_predictions = false;
    };
    TOML = {
      format_on_save = "off";
    };
    Yaml = {
      format_on_save = "off";
    };
    SQL = {
      format_on_save = "off";
    };
    Nix = {
      language_servers = [
        "!nixd"
        "nil"
      ];
    };
  };
  slash_commands = {
    docs.enabled = true;
    cargo_workspace.enabled = true;
  };
  agent = {
    stream_edits = true;
    preferred_completion_mode = "burn";
    play_sound_when_agent_done = true;
    notify_when_agent_waiting = "all_screens";
    enable_feedback = false;
    default_model = {
      provider = "openrouter";
      model = "GPT-5";
    };
    thread_summary_model = {
      provider = "openrouter";
      model = "GPT-5 Nano";
    };
    commit_message_model = {
      provider = "openrouter";
      model = "GPT-5 Nano";
    };
    inline_assistant_model = {
      provider = "openrouter";
      model = "GPT-5 Mini";
    };
  };
  session = {
    restore_unsaved_buffers = true;
  };
  debugger = {
    button = true;
  };
  tab_bar.show_nav_history_buttons = true;
  tabs = {
    file_icons = true;
    git_status = true;
    show_diagnostics = "all";
  };
  file_finder = {
    modal_max_width = "medium";
  };
  active_pane_modifiers = {
    inactive_opacity = 0.7;
  };
  indent_guides = {
    coloring = "indent_aware";
    background_coloring = "indent_aware";
    active_line_width = 2;
  };
  terminal = {
    button = true;
    font_family = "JetBrains Mono";
    scrollbar = {
      show = "auto";
    };
  };
  icon_theme = {
    mode = "system";
    light = "JetBrains New UI Icons (Light)";
    dark = "JetBrains New UI Icons (Dark)";
  };
  theme = {
    mode = "system";
    dark = "Gruvbox Dark Hard";
    light = "Gruvbox Light Hard";
  };
  vim = {
    toggle_relative_line_numbers = true;
    use_smartcase_find = true;
  };
  diagnostics = {
    include_warnings = true;
    inline = {
      enabled = true;
      padding = 8;
      min_column = 80;
      update_debounce_ms = 150;
    };
    lsp_pull_diagnostics = {
      enabled = true;
      debounce_ms = 50;
    };
  };
  edit_predictions = {
    mode = "subtle";
    disabled_globs = [
      "comment"
      "string"
    ];
  };
  lsp = {
    nil.initialization_options = {
      formatting = {
        command = [ "${pkgs.nixfmt}/bin/nixfmt" ];
      };
    };
    gopls = {
      initialization_options = {
        buildFlags = [
          "-tags=integration"
          "-gcflags=all=-N -l"
        ];
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
        check.workspace = true;
        hover.actions.references.enable = true;
        completion = {
          fullFunctionSignatures.enable = true;
        };
      };
    };
  };
}
