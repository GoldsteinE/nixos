{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,lv3:ralt_switch,misc:typo,nbsp:level3";
    displayManager = {
      autoLogin = {
        enable = true;
        user = "goldstein";
      };
      lightdm = {
        enable = true;
        greeter.enable = false;
      };
      defaultSession = "xsession";
      session = [{
        manage = "desktop";
        name = "xsession";
        start = ''exec $HOME/.xsession'';
      }];
    };
  };

  users.users.goldstein.extraGroups = [ "audio" "video" ];
  security.sudo.extraRules = [{
    users = [ "goldstein" ];
    commands = [{
      command = "${pkgs.slock}/bin/slock";
      options = [ "NOPASSWD" ];
    }];
  }];

  environment.systemPackages = with pkgs; [
    alacritty
    ksnip
    maim
    feh
    xclip
    slock
    peek
    rofi
    yubikey-touch-detector
    libnotify
  ];

  programs.light.enable = true;
}
