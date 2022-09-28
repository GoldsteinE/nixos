username: homeDirectory: { config, pkgs, dotfiles, desktop, ... }:

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
    file = ({
      ".local/bin/rofi-otp" = {
        executable = true;
        text = ''
          #!${pkgs.bash}/bin/bash
          set -euo pipefail
          cd $PASSWORD_STORE_DIR/otp
          ${pkgs.fd}/bin/fd -t f --strip-cwd-prefix \
            | ${pkgs.gnused}/bin/sed 's/\.gpg$//' \
            | ${pkgs.rofi}/bin/rofi \
              -theme ${pkgs.rofi}/share/rofi/themes/android_notification \
              -dmenu -i \
              -font 'Noto Sans 32' \
            | ${pkgs.findutils}/bin/xargs -I{} ${pass}/bin/pass otp "otp/{}" \
            | ${pkgs.findutils}/bin/xargs ${pkgs.xdotool}/bin/xdotool type
        '';
      };
      ".cargo/config.toml".text = ''
        [target.x86_64-unknown-linux-gnu]
        linker = "clang"
        rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]

        [build]
        rustc-wrapper = "${pkgs.sccache}/bin/sccache"
      '';
    }) // pkgs.lib.genAttrs
      ([
        ".ghc"
        ".p10k.zsh"
        ".config/nvim"
      ] ++ (if desktop then [
        ".config/alacritty"
        ".config/rofi"
        ".config/wired"
        ".config/yubikey-touch-detector"
        ".config/bspwm/desktop.jpg"
      ] else [ ]))
      (name: {
        source = "${dotfiles}/${name}";
        recursive = true;
      });
  };

  xsession = ifDesktop {
    enable = true;
    windowManager.bspwm = import ./home/bspwm.nix pkgs;
  };

  accounts.email.accounts.root = rec {
    primary = true;
    realName = "Max Siling";
    address = "root@goldstein.rs";
    userName = address;
    gpg = {
      key = "0BAF2D87CB43746F62372D78DE6031ABA0BB269A";
      signByDefault = true;
    };
    imap = {
      host = "mail.goldstein.rs";
      port = 993;
    };
    smtp = {
      host = imap.host;
      port = 465;
    };
    passwordCommand = "pass mail";
    aerc = {
      enable = true;
      extraAccounts = {
        pgp-auto-sign = true;
      };
    };
  };

  programs = {
    command-not-found.enable = true;
    zathura.enable = desktop;
    password-store = {
      enable = true;
      package = pass;
    };
    aerc = {
      enable = true;
      extraConfig = {
        general = {
          pgp-provider = "gpg";
          unsafe-accounts-conf = true;
        };
        ui.threading-enabled = true;
        filters = {
          "text/plain" = "cat";
        };
      };
      extraBinds = {
        messages = rec {
          k = ":prev 1<Enter>";
          "<up>" = k;
          j = ":next 1<Enter>";
          "<down>" = j;
          "<c-j>" = ":next-folder<Enter>";
          "<c-k>" = ":prev-folder<Enter>";
          "<enter>" = ":view<Enter>";
        };
        compose = {
          "<tab>" = ":next-field";
        };
        "compose::editor" = {
          "$ex" = "<C-x>";
        };
      };
    };

    zsh = {
      enable = true;
      initExtra = builtins.readFile "${dotfiles}/.zshrc";
      sessionVariables = {
        CARGO_TARGET_DIR = "/target/misc";
      };
    };

    direnv = import ./home/direnv.nix;
    git = import ./home/git.nix pkgs.gitAndTools.gitFull;
  };

  services = {
    pass-secret-service.enable = desktop;
    sxhkd = ifDesktop {
      enable = true;
      extraConfig = builtins.readFile "${dotfiles}/.config/sxhkd/sxhkdrc";
    };

    espanso = ifDesktop (import ./home/espanso.nix);
    polybar = ifDesktop (import ./home/polybar.nix pkgs);
  };

  xdg.mimeApps.associations.removed = ifDesktop {
    "application/pdf" = "chromium-browser.desktop";
  };
  xdg.mimeApps.defaultApplications = ifDesktop {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };
}
