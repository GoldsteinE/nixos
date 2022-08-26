{ pkgs, inputs, config, ... }: {
  services = {
    logind.lidSwitchExternalPower = "ignore";
    kmscon = {
      enable = true;
      hwRender = true;
      extraOptions = let x = config.services.xserver; in "--xkb-layout ${x.layout} --xkb-options ${x.xkbOptions}";
      extraConfig = "font-size=32";
      fonts = [{
        name = "Iosevka Term";
        package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
      }];
    };
    openssh = {
      enable = true;
      openFirewall = false;
      passwordAuthentication = false;
      listenAddresses = [{
        addr = "127.0.0.1";
        port = 22;
      }];
    };
    xserver = {
      enable = true;
      layout = "us,ru";
      xkbOptions = "grp:caps_toggle,lv3:ralt_switch,misc:typo,nbsp:level3";
      libinput = {
        enable = true;
        touchpad = {
          accelSpeed = "0.7";
          accelProfile = "adaptive";
        };
      };
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option "metamodes" "nvidia-auto-select +0+0 { ForceCompositionPipeline = On }"
      '';
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
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
    openvpn.servers.work = {
      config = "config /etc/openvpn/vpn.ovpn";
      updateResolvConf = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      media-session.config.bluez-monitor.rules.actions.update-pros."bluez5.autoswitch-profile" = true;
    };
    nginx = {
      enable = true;
      enableReload = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "requests.test".locations."/".proxyPass = "http://localhost:55555/";
      };
    };
  };

  systemd.user.services = {
    wired = {
      description = "Wired notification daemon";
      partOf = [ "graphical-session.target" ];
      path = [ inputs.wired-notify.packages.x86_64-linux.wired ];
      script = "wired";
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
      };
    };
  };

}
