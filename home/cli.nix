{ tmpfilesGenRule, root, ... }: {
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
  };
}
