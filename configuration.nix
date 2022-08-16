{ config, pkgs, inputs, system, ... }:

let
  rust = pkgs.rust-bin.nightly."2021-06-14".default;
  naersk-lib = inputs.naersk.lib."${system}".override {
    cargo = rust;
    rustc = rust;
  };

in

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    plymouth = {
      enable = true;
    };
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
    };
    initrd = {
      kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];
      luks = {
        yubikeySupport = true;
        devices.root = {
          device = "/dev/nvme0n1p2";
          preLVM = true;
          yubikey = {
            slot = 2;
            twoFactor = true;
            saltLength = 64;
            keyLength = 64;
            storage = {
              device = "/dev/nvme0n1p1";
              path = "/crypt-storage/default";
            };
          };
        };
      };
    };
    kernelParams = [ "net.ifnames=0" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nix.registry = {
    n.flake = inputs.nixpkgs;
    nixpkgs.flake = inputs.nixpkgs;
    templates.flake = inputs.t;
    t.flake = inputs.t;
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = false; # We're managing sound via pipewire
  hardware = {
    gpgSmartcards.enable = true;
    bluetooth.enable = true;
    video.hidpi.enable = true;
    nvidia = {
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xpadneo.enable = true;
  };

  security = {
    rtkit.enable = true;
    pam.loginLimits = [
      {
        domain = "goldstein";
        item = "memlock";
        type = "hard";
        value = "1048576";
      }
    ];
    pam.yubico = {
      enable = true;
      mode = "challenge-response";
      challengeResponsePath = "/var/yubico";
    };
    sudo.extraConfig = ''
      Defaults timestamp_timeout = 0
    '';
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    logind.lidSwitchExternalPower = "ignore";
    xserver = {
      enable = true;
      layout = "us,ru";
      xkbOptions = "grp:caps_toggle,lv3:ralt_switch,misc:typo,nbsp:level3";
      libinput = {
        enable = true;
        touchpad = {
          accelSpeed = "0.7";
          accelProfile = "adaptive";
        };
      };
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
      '';
      displayManager = {
        autoLogin = {
          enable = true;
          user = "goldstein";
        };
        lightdm = {
          enable = true;
          greeter.enable = false;
        };
        defaultSession = "none+bspwm";
      };
      windowManager.bspwm.enable = true;
    };
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    openvpn.servers.work = {
      config = "config /etc/openvpn/vpn.ovpn";
      updateResolvConf = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      media-session.config.bluez-monitor.rules.actions.update-pros."bluez5.autoswitch-profile" = true;
    };
    nginx = {
      enable = true;
      enableReload = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "requests.test".locations."/".proxyPass = "http://localhost:55555/";
      };
    };
  };

  systemd.user.services = {
    wired = {
      description = "Wired notification daemon";
      partOf = [ "graphical-session.target" ];
      path = [ inputs.wired-notify.packages.x86_64-linux.wired ];
      script = "wired";
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
      };
    };
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
  virtualisation.docker.enable = true;

  virtualisation.oci-containers.containers = {
    httpbin = {
      image = "darklynx/request-baskets";
      ports = [
        "55555:55555"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.neovim-nightly-overlay.overlay
      inputs.rust-overlay.overlays.default
    ];
  };

  users.users.goldstein = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" "video" ];
    home = "/home/goldstein";
    shell = "/run/current-system/sw/bin/zsh";
  };

  environment.systemPackages = with pkgs; [
    inputs.wired-notify.packages.x86_64-linux.wired
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

  networking = {
    hostName = "think";
    dhcpcd.wait = "if-carrier-up";
    hosts = {
      "127.0.0.1" = [
        "requests.test"
      ];
      "163.172.167.207" = [
        "bt.t-ru.org"
        "bt2.t-ru.org"
        "bt3.t-ru.org"
        "bt4.t-ru.org"
      ];
    };
    networkmanager.enable = true;
    firewall.allowedUDPPorts = [ 51820 ];

    wg-quick.interfaces.wg0 = {
      autostart = false;
      privateKeyFile = "/etc/wireguard/mullvad.key";
      address = [
        "10.68.26.80/32"
        "fc00:bbbb:bbbb:bb01::5:1a4f/128"
      ];
      dns = [ "193.138.218.74" ];
      peers = [
        {
          publicKey = "Qn1QaXYTJJSmJSMw18CGdnFiVM0/Gj/15OdkxbXCSG0=";
          endpoint = "193.138.218.220:51820";
          allowedIPs = [
            "0.0.0.0/5"
            "8.0.0.0/7"
            "11.0.0.0/8"
            "12.0.0.0/6"
            "16.0.0.0/4"
            "32.0.0.0/3"
            "64.0.0.0/2"
            "128.0.0.0/3"
            "160.0.0.0/5"
            "168.0.0.0/6"
            "172.0.0.0/12"
            "172.32.0.0/11"
            "172.64.0.0/10"
            "172.128.0.0/9"
            "173.0.0.0/8"
            "174.0.0.0/7"
            "176.0.0.0/4"
            "192.0.0.0/9"
            "192.128.0.0/11"
            "192.160.0.0/13"
            "192.169.0.0/16"
            "192.170.0.0/15"
            "192.172.0.0/14"
            "192.176.0.0/12"
            "192.192.0.0/10"
            "193.0.0.0/9"
            "193.128.0.0/13"
            "193.136.0.0/15"
            "193.138.0.0/17"
            "193.138.128.0/18"
            "193.138.192.0/20"
            "193.138.208.0/21"
            "193.138.216.0/23"
            "193.138.218.0/25"
            "193.138.218.128/26"
            "193.138.218.192/28"
            "193.138.218.208/29"
            "193.138.218.216/30"
            "193.138.218.221/32"
            "193.138.218.222/31"
            "193.138.218.224/27"
            "193.138.219.0/24"
            "193.138.220.0/22"
            "193.138.224.0/19"
            "194.0.0.0/7"
            "196.0.0.0/6"
            "200.0.0.0/5"
            "208.0.0.0/4"
          ];
        }
      ];
    };
    wg-quick.interfaces.wg1 = {
      address = [ "172.16.0.2/20" ];
      privateKeyFile = "/etc/wireguard/srvr.key";
      listenPort = 51820;
      peers = [
        {
          publicKey = "IqSILmfZJvrEl+5nMrqshTSOI5xX61mAsFIPhn3m4i4=";
          endpoint = "194.163.129.129:51820";
          allowedIPs = [ "172.16.0.0/20" ];
        }
      ];
    };
  };

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
  system.stateVersion = "20.09"; # Did you read the comment?
}
