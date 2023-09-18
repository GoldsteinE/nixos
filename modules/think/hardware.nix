{ ... }: {
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
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

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
    '';
    dpi = 288;
    libinput = {
      enable = true;
      touchpad = {
        accelSpeed = "0.7";
        accelProfile = "adaptive";
      };
    };
  };

  services.logind.lidSwitchExternalPower = "ignore";
}
