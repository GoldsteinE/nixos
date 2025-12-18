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
  };

  services.libinput = {
    enable = true;
    touchpad = {
      accelSpeed = "0.7";
      accelProfile = "adaptive";
      tapping = true;
      tappingButtonMap = "lrm";
      tappingDragLock = false;
    };
  };

  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
}
