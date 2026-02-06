{ pkgs, ... }:
{
  programs.git = {
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
}
