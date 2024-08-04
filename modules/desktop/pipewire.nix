{ pkgs, ... }: {
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
