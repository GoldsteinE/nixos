{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/34a48e78-214a-4970-bb09-4b7af2e6e0e4";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/34a48e78-214a-4970-bb09-4b7af2e6e0e4";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/etc" =
    { device = "/dev/disk/by-uuid/34a48e78-214a-4970-bb09-4b7af2e6e0e4";
      fsType = "btrfs";
      options = [ "subvol=etc" ];
    };

  fileSystems."/srv" =
    { device = "/dev/disk/by-uuid/34a48e78-214a-4970-bb09-4b7af2e6e0e4";
      fsType = "btrfs";
      options = [ "subvol=srv" ];
    };

  fileSystems."/target" =
    { device = "/dev/disk/by-uuid/34a48e78-214a-4970-bb09-4b7af2e6e0e4";
      fsType = "btrfs";
      options = [ "subvol=target" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/75F3-62F4";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/3c1da20f-3a99-4705-a119-4ec0c96c6882"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
