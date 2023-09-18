{ pkgs, ... }: {
  sound.enable = false; # We're managing sound via pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
  ];
}
