{ ... }: {
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      enableCryptodisk = true;
      extraGrubInstallArgs = [ "--modules=part_gpt" ];
    };
  };
}
