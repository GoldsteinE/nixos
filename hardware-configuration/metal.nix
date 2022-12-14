{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/afabefab-645e-4776-913e-0576c0a0e492";
      fsType = "btrfs";
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
    };

  boot.initrd.luks.devices = {
    fsroot.device = "/dev/disk/by-id/md-uuid-ab95e5f4:b78da993:1cbbd753:6daa6abb";
  };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/c5181735-c0c4-4a35-bd7a-0febe3a20558";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
