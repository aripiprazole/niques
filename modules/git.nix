{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    includes = [
      {
        condition = "gitdir:~/Cloudwalk/**";
        contents = {
          user = {
            name = "Gabrielle Oliveira";
            email = "gabrielle.oliveira@cloudwalk.io";
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA1w2UXALVRmKAucVOBGMo7rXkkqqfSFqNwx9ZZ+x14g";
          };
        };
      }
    ];
    settings = {
      user = {
        name = "Gabrielle Oliveira";
        email = "you@gabx.io";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHeK9z5uJU6w1bNKYyUDGlh+wqfws1jJcec83zlolGxp";
      };
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
