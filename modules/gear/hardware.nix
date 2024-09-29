{ ... }: {
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    gpgSmartcards.enable = true;
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    xpadneo.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad = {
      accelSpeed = "0.7";
      accelProfile = "adaptive";
      tapping = true;
      tappingButtonMap = "lrm";
    };
  };

  services.logind.lidSwitchExternalPower = "ignore";
}
