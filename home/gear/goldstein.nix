{ root, pkgs, inputs, ... }: {
  imports = [
    "${root}/home/cli.nix"
    "${root}/home/git.nix"
    "${root}/home/pass.nix"
    "${root}/home/desktop/wayland.nix"
    # display configuration
    "${root}/home/gear/kanshi.nix"
    "${root}/home/desktop/sioyek.nix"
    "${root}/home/desktop/mpv.nix"
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

    # scale + hardware cursors
    pointerCursor.size = pkgs.lib.mkForce 12;
  };

  services.easyeffects = {
    enable = true;
    preset = "fw16";
  };
  home.file.".config/easyeffects/fw16.json".source = "${root}/dotfiles/.config/easyeffects/fw16.json";

  _module.args = {
    inherit inputs;
    pass = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    gitSignByDefault = true;
    tmpfilesGenRule = import "${root}/home/tmpfiles-gen-rule.nix" "/home/goldstein";
  };
}
