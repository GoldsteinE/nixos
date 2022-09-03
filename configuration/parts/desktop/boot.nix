{ pkgs, ... }: {
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
}
