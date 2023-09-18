username: homeDirectory: { config, pkgs, lib, dotfiles, desktop, ... }:

let
  pass = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  ifDesktop = x: if desktop && username != "root" then x else { };
in
{
  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";
    sessionVariables = {
      SCCACHE_DIR = "/target/sccache";
    };
    file = {
      ".cargo/config.toml".text = ''
        [target.x86_64-unknown-linux-gnu]
        linker = "clang"
        rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold", "-C", "split-debuginfo=unpacked"]

        [build]
        rustc-wrapper = "${pkgs.sccache}/bin/sccache"
      '';
    };
  };

  programs = {
    password-store = {
      enable = true;
      package = pass;
    };
    sioyek = {
      enable = desktop;
      config.status_bar_font_size = "36";
      config.page_separator_width = "4";
    };

    zsh = {
      sessionVariables = {
        CARGO_TARGET_DIR = "/target/misc";
      };
    };
  };

  services = {
    pass-secret-service.enable = desktop;
  };
}
