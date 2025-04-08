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
        gpg.ssh.program = "${pkgs._1password-gui}/MacOS/op-ssh-sign";
        filter.lfs.smudge = "git-lfs smudge --skip %f";
        filter.lfs.process = "git-lfs filter-proccess --skip";
        filter.lfs.clean = "git-lfs clean -- %f";
        filter.lfs.required = true;
        url."git@github.com:".insteadOf = "git://github.com";
        commit.gpgsign = true;
        core.fsmonitor = true;
        init.defaultBranch = true;
        push.autoSetupRemote = true;
      };
    };
  }
