{ root, ... }: {
  imports = [
    "${root}/home/cli.nix"
    "${root}/home/git.nix"
  ];
  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "22.11";
  };
  _module.args = {
    gitSignByDefault = false;
    tmpfilesGenRule = import "${root}/home/tmpfiles-gen-rule.nix" "/home/goldstein";
  };
}
