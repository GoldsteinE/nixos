{ root, ... }: {
  imports = [
    "${root}/home/cli.nix"
  ];
  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "22.11";
  };
  _module.args = {
    gitSignByDefault = false;
    tmpfilesGenRule = import "${root}/home/tmpfiles-gen-rule.nix" "/root";
  };
}
