{ config, pkgs, dotfiles, ... }:

let
  desktop = true;
  ifDesktop = x: if desktop then x else { };

in
{
  home = {
    username = "goldstein";
    homeDirectory = "/home/goldstein";
    stateVersion = "22.11";
    file = pkgs.lib.genAttrs
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

  programs = {
    command-not-found.enable = true;
    password-store.enable = true;
    zathura.enable = desktop;

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
