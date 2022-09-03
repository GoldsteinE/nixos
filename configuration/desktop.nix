{ config, pkgs, inputs, system, ... }:

let
  naersk = pkgs.callPackage inputs.naersk { };
in

{
  imports = [
    ./parts/nix.nix
    ./parts/services.nix
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
      "srvr.key".encrypted = ./secrets/desktop/srvr.key;
    };
  };
  # Secrets are needed before VPN starts
  systemd.services.classified.before = [ "network.target" ];

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
    ssh.knownHosts.srvr = {
      extraHostNames = [ "goldstein.rs" "194.163.129.129" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINAdhEAM6e1fSiusg4bGEK/aBXnzCwp70qsj6qGvKOWn";
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

  environment.systemPackages = with pkgs; [
    inputs.simp.packages."${system}".simp
    inputs.wired-notify.packages."${system}".wired
    (steam.override {
      extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
    })

    alacritty
    appimage-run
    cargo-edit
    chromium
    electrum
    espanso
    firefox
    feh
    haskell.compiler.ghc924
    hexchat
    python3Packages.ipython
    ksnip
    libnotify
    lm_sensors
    maim
    nheko
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
    xsecurelock
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
