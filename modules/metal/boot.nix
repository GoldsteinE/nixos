{ ... }: {
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/disk/by-id/wwn-0x500a0751160d3995";
      enableCryptodisk = true;
      extraGrubInstallArgs = [ "--modules=part_gpt" ];
    };
    kernelModules = [ "kvm-amd" ];
    initrd.kernelModules = [ "md_mod" "r8169" ];
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
    initrd.luks.devices = {
      fsroot.device = "/dev/disk/by-id/md-uuid-ab95e5f4:b78da993:1cbbd753:6daa6abb";
    };
    initrd.network = {
      enable = true;
      ssh = {
        enable = true;
        port = 17643;
        hostKeys = [
          "/etc/secrets/initrd/ssh_host_ed25519_key"
        ];
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfvajQ3g5zDNGlGFfMrK9X1v4o5TBsSkP55KGn69Z4T"
        ];
      };
    };
  };
}
