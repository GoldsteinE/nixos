{ ... }: {
  sound.enable = false; # We're managing sound via pipewire
  hardware = {
    gpgSmartcards.enable = true;
    bluetooth.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xpadneo.enable = true;
  };
}
