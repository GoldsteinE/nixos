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
    };
  };

  systemd.user.tmpfiles.rules =
    let
      genRule = (file: "L ${homeDirectory}/${file} - - - - ${homeDirectory}/sysconf/dotfiles/${file}");
    in
    (map genRule [
      ".ghc/ghci.conf"
      ".p10k.zsh"
      ".config/nvim"
    ]) ++ (if desktop then
      map genRule [
        ".config/alacritty"
        ".config/rofi"
        ".config/wired"
        ".config/yubikey-touch-detector"
        ".config/bspwm/desktop.jpg"
      ] else [ ]);

  # activation = ({
  #   linkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #     for dotfile in .ghc/ghci.conf .p10k.zsh .config/nvim; do
  #       echo "Linking '$dotfile'..."
  #       $DRY_RUN_CMD ln -sf $VERBOSE_ARG "$HOME/sysconf/dotfiles/$dotfile" "$HOME"
  #     done
  #   '';
  # } // ifDesktop {
  #   linkDesktopDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #     for dotfile in .config/alacritty .config/rofi .config/wired .config/yubikey-touch-detector .config/bspwm/desktop.jpg; do
  #       echo "Linking '$dotfile'..."
  #       $DRY_RUN_CMD ln -sf $VERBOSE_ARG "$HOME/sysconf/dotfiles/$dotfile" "$HOME"
  #     done
  #   '';
  # });

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

    autorandr = ifDesktop {
      enable = true;
      hooks.postswitch.restart-polybar = ''
        ${pkgs.systemd}/bin/systemctl --user restart polybar
      '';
      profiles = {
        laptop = {
          fingerprint.eDP-1-1 = "00ffffffffffff000e6f001500000000001d0104b5221378032112a85236b5261050540000000101010101010101010101010101010140ce00a0f07028803020350058c210000018000000000000000000000000000000000018000000fe0043534f542054330a2020202020000000fe004d4e463630314541312d310a20011802030f00e3058000e6060501737321000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008b";
          config = {
            eDP-1-1 = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "3840x2160";
            };
          };
        };
        work = {
          fingerprint = {
            HDMI-0 = "00ffffffffffff0061a9012701000000141e0103803c2178afebc5ad4f45af270c5054a5cb0081c081809500a9c0b300d1c0a9c00101565e00a0a0a029503020350055502100001a000000ff0032373537353030303334393133000000fd0030901ef03c010a202020202020000000fc004d69204d6f6e69746f720a202001dd020346f34d0102030405901213141f4d5c3f23090707830100006a030c002000387820000067d85dc40178c0006d1a000002013090ed0000000000e305e301e6060701605000fd8180a070381f402040450055502100001ef5bd00a0a0a032502040450055502100001e9ee00078a0a032501040350055502100001e00000043";
            eDP-1-1 = "00ffffffffffff000e6f001500000000001d0104b5221378032112a85236b5261050540000000101010101010101010101010101010140ce00a0f07028803020350058c210000018000000000000000000000000000000000018000000fe0043534f542054330a2020202020000000fe004d4e463630314541312d310a20011802030f00e3058000e6060501737321000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008b";
          };
          config = {
            eDP-1-1 = {
              enable = true;
              mode = "2560x1440";
              position = "0x1440";
            };
            HDMI-0 = {
              enable = true;
              primary = true;
              mode = "2560x1440";
              position = "0x0";
            };
          };
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
