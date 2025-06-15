{ ... }: {
  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-label/fsroot";
        fsType = "btrfs";
        options = [ "subvol=root" ];
      };

    "/home" =
      {
        device = "/dev/disk/by-label/fsroot";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };

    "/etc" =
      {
        device = "/dev/disk/by-label/fsroot";
        fsType = "btrfs";
        options = [ "subvol=etc" ];
      };
    "/boot" =
      {
        device = "/dev/disk/by-label/UEFI";
        fsType = "vfat";
        options = [ "umask=0077" "defaults" ];
      };
  };

  swapDevices =
    [{ device = "/dev/disk/by-label/swap"; }];
}
