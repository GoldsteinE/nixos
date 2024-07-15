{ ... }: {
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    gpgSmartcards.enable = true;
    bluetooth.enable = true;
    nvidia = {
      open = false;
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
      prime = {
        sync.enable = false;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    xpadneo.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
    '';
    dpi = 288;
  };

  services.libinput = {
    enable = true;
    touchpad = {
      accelSpeed = "0.7";
      accelProfile = "adaptive";
    };
  };

  services.logind.lidSwitchExternalPower = "ignore";
}
