{ root, pkgs, ... }: {
  imports = [
    "${root}/home/cli.nix"
    "${root}/home/git.nix"
    "${root}/home/pass.nix"
    "${root}/home/desktop/xorg.nix"
    "${root}/home/desktop/sioyek.nix"
  ];
  home = {
    username = "goldstein";
    homeDirectory = "/home/goldstein";
    stateVersion = "22.11";

    # not in module because of fs layout reliance
    sessionVariables = {
      SCCACHE_DIR = "/target/sccache";
      CARGO_TARGET_DIR = "/target/misc";
    };
  };
  _module.args = {
    pass = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    gitSignByDefault = true;
    tmpfilesGenRule = import "${root}/home/tmpfiles-gen-rule.nix" "/home/goldstein";
  };
}
