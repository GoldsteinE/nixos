package: {
  enable = true;
  inherit package;
  lfs.enable = true;
  userName = "Goldstein";
  userEmail = "root@goldstein.rs";
  aliases = {
    uncommit = "reset --soft HEAD^";
    unadd = "reset";
    praise = "blame";
  };
  signing = {
    key = "0BAF2D87CB43746F62372D78DE6031ABA0BB269A";
    signByDefault = true;
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
  };
}
