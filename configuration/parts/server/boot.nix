{ ... }: {
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
      enableCryptodisk = true;
      extraGrubInstallArgs = [ "--modules=part_gpt" ];
    };

    initrd.luks.devices.root.preLVM = true;
  };
}
