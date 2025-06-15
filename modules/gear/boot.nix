{ pkgs, lib, inputs, ... }: {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  environment.systemPackages = [
    pkgs.sbctl
  ];
  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd sway";
  };
  boot = {
    plymouth = {
      enable = true;
      themePackages = [ pkgs.plymouth-blahaj-theme ];
      theme = "blahaj";
    };
    loader = {
      grub.enable = false;
      # Managed by lanzaboote.
      systemd-boot.enable = lib.mkForce false;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    initrd = {
      systemd.enable = true;
      kernelModules = [ "dm-snapshot" "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
      luks = {
        fido2Support = false; # handled by systemd
        devices.root = {
          # Todo: a better way to identify?
          device = "/dev/disk/by-uuid/96b6ceb2-e10a-4647-aa3c-bbf9ba7dc2f9";
          preLVM = true;
          crypttabExtraOpts = ["fido2-device=auto"];
        };
      };
      # can't use luks.devices, since already mounted root is needed
      # junk drive is not yet installed
      # postMountCommands = ''
      #   cryptsetup luksOpen --key-file /mnt-root/junkpass /dev/disk/by-label/junk junkfs
      # '';
    };
    kernelParams = [ "net.ifnames=0" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
