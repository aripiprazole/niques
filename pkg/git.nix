{ pkgs, ... }:
  {
    programs.git = {
      enable = true;
      extraConfig = {
        user = {
          name = "Gabrielle Oliveira";
          email = "you@gabx.io";
          signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeK9z5uJU6w1bNKYyUDGlh+wqfws1jJcec83zlolGxp";
        };
        gpg.format = "ssh";
        gpg.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
        filter.lfs = {
          smudge = "git-lfs smudge --skip %f";
          process = "git-lfs filter-proccess --skip";
          clean = "git-lfs clean -- %f";
          required = true;
        };
        url."git@github.com:".insteadOf = "git://github.com";
        commit.gpgsign = true;
        core = {
          fsmonitor = true;
          editor = "${pkgs.helix}/bin/hx";
          autocrlf = "input";
          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        };
        init.defaultBranch = true;
        push.autoSetupRemote = true;
      };
    };
  }
