{ pkgs, gitSignByDefault, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    settings = {
      user = {
        name = "Max Siling";
        email = "root@goldstein.lol";
      };
      alias = {
        uncommit = "reset --soft HEAD^";
        unadd = "reset";
        praise = "blame";
      };
      hub.protocol = "ssh";
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      advice.detachedHead = false;
      sendemail = {
        smtpserver = "mail.goldstein.rs";
        smtpuser = "root@goldstein.rs";
        smtpencryption = "ssl";
        smtpserverport = 465;
      };
      credential.helper = "libsecret";
    };
    signing = {
      key = "0BAF2D87CB43746F62372D78DE6031ABA0BB269A";
      signByDefault = gitSignByDefault;
    };
    includes = [{
      condition = "gitdir:~/work/";
      path = "~/work/.gitconfig";
    }];
  };
  programs.difftastic = {
    enable = true;
    git.enable = true;
    options = {
      background = "dark";
    };
  };
}
