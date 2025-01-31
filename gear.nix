inputs @ { nixpkgs, nixos-hardware, classified, home-manager, lix-module, fw-fanctrl, ... }:
nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  modules = [
    # Lix instead of Nix
    lix-module.nixosModules.default
    # external imports
    nixos-hardware.nixosModules.framework-16-7040-amd
    classified.nixosModules."${system}".default
    home-manager.nixosModules.home-manager
    fw-fanctrl.nixosModules.default
    # common stuff
    ./modules/nix.nix
    # ./modules/kmscon.nix
    ./modules/users.nix
    ./modules/cli.nix
    ./modules/rust-dev.nix
    ./modules/misc-dev.nix
    # desktop-specific stuff
    ./modules/desktop/locale.nix
    ./modules/desktop/fonts.nix
    ./modules/desktop/personal-xray.nix
    # use unbound to switch between VPN dns and regular DNS
    ./modules/desktop/unbound.nix
    ({ ... }: {
      fonts.fontconfig = {
        enable = true;
        antialias = true;
        hinting = {
          enable = true;
          autohint = false;
          style = "slight";
        };
        subpixel = {
          rgba = "none";
          lcdfilter = "none";
        };
      };
    })
    # Deal with backups a bit later.
    # ./modules/desktop/btrbk.nix
    ./modules/tarsnap.nix
    # That too.
    ./modules/desktop/work-vpn.nix
    ./modules/desktop/jupyter.nix
    ./modules/desktop/security.nix
    ({ ... }: {
      users.users.goldstein.extraGroups = [ "audio" "video" ];
      nixpkgs.overlays = [ (final: prev: {
        sway-unwrapped = inputs.nixpkgs-wayland.packages.${final.system}.sway-unwrapped;
      }) ];
    })
    # Doesn't work on Wayland :(
    # ./modules/desktop/wired.nix
    ./modules/desktop/pipewire.nix
    ./modules/desktop/razer.nix
    ./modules/desktop/steam.nix
    ./modules/desktop/dev-tools.nix
    ./modules/desktop/misc-apps.nix
    ({ ... }: {
      services.fwupd.enable = true;
      programs.fw-fanctrl = {
        enable = true;
        config = {
          defaultStrategy = "laziest";
          strategies = with builtins; (fromJSON (readFile "${fw-fanctrl}/config.json")).strategies // {
            silent.speedCurve = [
              { temp = 0; speed = 0; }
              { temp = 45; speed = 0; }
              { temp = 65; speed = 12; }
              { temp = 70; speed = 17; }
              { temp = 75; speed = 25; }
              { temp = 85; speed = 50; }
            ];
          };
        };
      };
    })
    ({ pkgs, ... }: {
      environment.systemPackages = [ pkgs.via ];
      services.udev.packages = [ pkgs.via ];
    })
    # I hate GNOME
    ({ ... }: {
      programs.dconf.enable = true;
    })
    # machine-specific stuff
    ./modules/gear/boot.nix
    ./modules/gear/hardware.nix
    ./modules/gear/partitions.nix
    ./modules/gear/networking.nix
    ./modules/gear/home-manager.nix
    # misc stuff, keep short
    ({ ... }: {
      system.stateVersion = "24.05";
      virtualisation.podman.enable = true;
      virtualisation.docker.enable = true;
    })
  ];
  specialArgs = {
    inherit inputs;
    root = ./.;
  };
}
