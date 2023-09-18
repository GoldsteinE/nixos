{ modulesPath, ... }: {
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
  hardware.cpu.amd.updateMicrocode = true;
}
