{ pkgs, gitSignByDefault, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    lfs.enable = true;
    userName = "Max Siling";
    userEmail = "root@goldstein.lol";
    aliases = {
      uncommit = "reset --soft HEAD^";
      unadd = "reset";
      praise = "blame";
    };
    signing = {
      key = "0BAF2D87CB43746F62372D78DE6031ABA0BB269A";
      signByDefault = gitSignByDefault;
    };
    difftastic = {
      enable = true;
      background = "dark";
    };
    includes = [{
      condition = "gitdir:~/work/";
      path = "~/work/.gitconfig";
    }];
    extraConfig = {
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
  };
}
