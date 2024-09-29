{ pkgs, ... }: {
  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
    };
    initrd = {
      kernelModules = [ "dm-snapshot" "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
      luks = {
        yubikeySupport = true;
        devices.root = {
          # Todo: a better way to identify?
          device = "/dev/disk/by-uuid/96b6ceb2-e10a-4647-aa3c-bbf9ba7dc2f9";
          preLVM = true;
          yubikey = {
            slot = 2;
            twoFactor = true;
            saltLength = 64;
            keyLength = 64;
            storage = {
              device = "/dev/disk/by-label/UEFI";
              path = "/crypt-storage/default";
            };
          };
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
