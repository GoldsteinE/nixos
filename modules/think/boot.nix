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
          device = "/dev/disk/by-label/system";
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
      postMountCommands = ''
        cryptsetup luksOpen --key-file /mnt-root/junkpass /dev/disk/by-label/junk junkfs
      '';
    };
    kernelParams = [ "net.ifnames=0" ];
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
