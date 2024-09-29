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
      };
  };

  swapDevices =
    [{ device = "/dev/disk/by-label/swap"; }];
}
