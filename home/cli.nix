{ tmpfilesGenRule, root, gitSignByDefault, ... }: {
  systemd.user.tmpfiles.rules = map tmpfilesGenRule [
    ".p10k.zsh"
    ".config/nvim"
    ".ghc/ghci.conf"
  ];
  programs = {
    command-not-found.enable = true;
    zsh = {
      enable = true;
      initExtra = builtins.readFile "${root}/dotfiles/.zshrc";
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "root@goldstein.lol";
          name = "Max Siling";
        };
        signing = {
          behavior = "drop";
          backend = "gpg";
          key = "0BAF2D87CB43746F62372D78DE6031ABA0BB269A";
        };
        git = {
          sign-on-push = gitSignByDefault;
        };
        ui = {
          pager = "less -FRX";
          diff.tool = ["difft" "--color=always" "$left" "$right"];
          show-cryptographic-signatures = true;
        };
      };
    };
  };
}
