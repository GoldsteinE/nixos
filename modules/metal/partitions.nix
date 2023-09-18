{ ... }: {
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/afabefab-645e-4776-913e-0576c0a0e492";
      fsType = "btrfs";
      options = [ "defaults" "compress=zstd" ];
    };
  fileSystems."/dump" =
    {
      device = "/dev/mapper/dump";
      fsType = "btrfs";
      encrypted = {
        enable = true;
        label = "dump";
        blkDev = "/dev/disk/by-id/wwn-0x5000cca25ed4aa16";
        keyFile = "/mnt-root/hddkey";
      };
      options = [ "defaults" "compress=zstd" ];
    };
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/c5181735-c0c4-4a35-bd7a-0febe3a20558";
      fsType = "ext4";
    };
}
