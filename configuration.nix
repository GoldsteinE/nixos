{ config, pkgs, inputs, system, ... }:

let
  naersk = pkgs.callPackage inputs.naersk { };
in

{
  imports = [
    ./parts/nix.nix
    ./parts/boot.nix
    ./parts/hardware.nix
    ./parts/security.nix
    ./parts/services.nix
    ./parts/networking.nix
  ];

  classified = {
    keys.default = "/classified.key";
    files = {
      "mullvad.key".encrypted = ./secrets/mullvad.key;
      "srvr.key".encrypted = ./secrets/srvr.key;
      "vpn.ovpn".encrypted = ./secrets/vpn.ovpn;
    };
  };
  # Secrets are needed before VPN starts
  systemd.services.classified.before = [ "network.target" ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    light.enable = true;
    zsh.enable = true;
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

  users.users.goldstein = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" "video" ];
    home = "/home/goldstein";
    shell = "/run/current-system/sw/bin/zsh";
  };

  environment.systemPackages = with pkgs; [
    inputs.simp.packages."${system}".simp
    inputs.wired-notify.packages."${system}".wired
    (steam.override {
      extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
    })

    alacritty
    appimage-run
    bat
    cargo-edit
    chromium
    curl
    difftastic
    dogdns
    electrum
    espanso
    fd
    firefox
    feh
    gcc
    haskell.compiler.ghc924
    git
    hexchat
    htop
    hub
    python3Packages.ipython
    jq
    killall
    ksnip
    libnotify
    lm_sensors
    maim
    man-pages
    ncdu
    neovim-nightly
    nheko
    openvpn
    pamixer
    pavucontrol
    peek
    playerctl
    polybarFull
    powertop
    pwgen
    python3
    qbittorrent
    ripgrep
    rnix-lsp
    rofi
    sccache
    silicon
    slack
    tdesktop
    tor-browser-bundle-bin
    unzip
    vim
    vlc
    wget
    xclip
    xsecurelock
    yadm
    yubikey-touch-detector
    zip
    zsh
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
