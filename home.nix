{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      wakatime-cli
      ngrok
      just
      jq
      fd
      ripgrep
      ffmpeg
      cmake
      tig
      fzf
      gh
      mkalias
      elan
      rustup
      nil
      nixfmt
      any-nix-shell
      pgcli
    ];

    file."Library/Application Support/com.mitchellh.ghostty/config" = {
      enable = true;
      source = ./ghostty/config;
    };

    sessionVariables = {
      EDITOR = "${pkgs.helix}/bin/hx";
    };
  };

  programs = {
    home-manager.enable = true;
    command-not-found.enable = false;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    btop = {
      enable = true;
      settings.vim_keys = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    _1password-shell-plugins = {
      enable = true;
      plugins = with pkgs; [
        gh
        awscli2
        cachix
      ];
    };

    zed-editor = {
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
        "opencode"
      ];
      userKeymaps = builtins.fromJSON (builtins.readFile ./zed/keymap.json);
      userSettings = import ./zed/settings.nix pkgs;
    };

    helix = {
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

    git = {
      enable = true;
      settings = {
        gpg.format = "ssh";
        gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        filter.lfs = {
          smudge = "git-lfs smudge --skip %f";
          process = "git-lfs filter-proccess --skip";
          clean = "git-lfs clean -- %f";
          required = true;
        };
        credential.helper = "store";
        url."git@github.com:".insteadOf = "git://github.com";
        url."ssh://git@github.com:".insteadOf = "https://github.com";
        commit.gpgsign = true;
        core = {
          fsmonitor = true;
          editor = "${pkgs.helix}/bin/hx";
          autocrlf = "input";
          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    zellij = {
      enable = true;
      settings = {
        simplified_ui = true;
        theme = "ansi";
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

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        character = {
          success_symbol = "[\\$](bold green)";
          error_symbol = "[\\$](bold red)";
        };
      };
    };

    zsh = {
      enable = true;
      initContent = ''
        PROMPT="$\{PROMPT\}"$'\n'
        eval "$(/opt/homebrew/bin/brew shellenv)"
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin

        # Auto-rename zellij tab to current directory
        function _zellij_rename_tab() {
          if [[ -n "$ZELLIJ" ]]; then
            local tab_name="''${PWD##*/}"
            nohup zellij action rename-tab "$tab_name" >/dev/null 2>&1
          fi
        }
        chpwd_functions+=(_zellij_rename_tab)
        _zellij_rename_tab
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

    # vscode = {
    #   enable = true;
    #   profiles.default = {
    #     extensions = with pkgs.vscode-marketplace; [
    #       vscodevim.vim
    #       usernamehw.errorlens
    #       rust-lang.rust-analyzer
    #       chadalen.vscode-jetbrains-icon-theme
    #       ms-vscode-remote.remote-ssh
    #       mkhl.direnv
    #       dbaeumer.vscode-eslint
    #       github.github-vscode-theme
    #       leanprover.lean4
    #       ocamllabs.ocaml-platform
    #       paperproof.paperproof
    #       wakatime.vscode-wakatime
    #       haskell.haskell
    #       tamasfe.even-better-toml
    #       fill-labs.dependi
    #     ];
    #     keybindings = import ./vscode/keybindings.nix;
    #     userSettings = import ./vscode/settings.nix;
    #   };
    # };
  };

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
}
