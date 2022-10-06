{ config, pkgs, inputs, system, ... }:

let
  naersk = pkgs.callPackage inputs.naersk { };
in

{
  imports = [
    ./parts/nix.nix
    ./parts/services.nix
    ./parts/jupyter.nix
    ./parts/goldstein.nix
    ./parts/cli.nix

    ./parts/desktop/boot.nix
    ./parts/desktop/hardware.nix
    ./parts/desktop/security.nix
    ./parts/desktop/services.nix
    ./parts/think/networking.nix
  ];

  classified = {
    keys.default = "/classified.key";
    files = {
      "mullvad.key".encrypted = ./secrets/desktop/mullvad.key;
      nix-netrc.encrypted = ./secrets/desktop/nix-netrc;
      btrbk = {
        encrypted = ./secrets/desktop/btrbk;
        user = "btrbk";
      };
    };
  };
  # Secrets are needed before VPN starts
  systemd.services.classified.before = [ "network.target" ];

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix.goldstein.rs"
    ];
    trusted-public-keys = [
      "metal:FFcepzDmAaAqlduU2SnEex+ozAOAYHo6BQTnagtxcd0="
    ];
  };
  nix.extraOptions = ''
    netrc-file = /var/secrets/nix-netrc
  '';

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    light.enable = true;
    steam.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "qt";
      enableSSHSupport = true;
    };
  };

  virtualisation.podman.enable = true;
  virtualisation.oci-containers.containers = {
    httpbin = {
      image = "darklynx/request-baskets";
      ports = [
        "55555:55555"
      ];
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    # for itch
    "electron-11.5.0"
  ];

  environment.systemPackages = with pkgs; [
    inputs.simp.packages."${system}".simp
    inputs.wired-notify.packages."${system}".wired
    (steam.override {
      extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
    })

    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer

    cargo-edit
    alacritty
    appimage-run
    chromium
    electrum
    espanso
    firefox
    feh
    haskell.compiler.ghc924
    hexchat
    itch
    python3Packages.ipython
    ksnip
    libnotify
    lm_sensors
    maim
    # nheko
    openvpn
    pamixer
    pavucontrol
    peek
    playerctl
    polybarFull
    powertop
    qbittorrent
    rofi
    sccache
    silicon
    slack
    tdesktop
    tor-browser-bundle-bin
    vlc
    xclip
    slock
    yubikey-touch-detector
    zulip
  ];

  fonts.fonts = with pkgs; [
    roboto
    noto-fonts
    noto-fonts-cjk
    font-awesome
    material-icons
    dejavu_fonts
    open-sans
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
  ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
    nixos.includeAllModules = true;
  };
}
