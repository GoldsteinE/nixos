{ inputs, ... }: {
  systemd.user.services.wired = {
    description = "Wired notification daemon";
    partOf = [ "graphical-session.target" ];
    path = [ inputs.wired-notify.packages.x86_64-linux.default ];
    script = "wired";
    serviceConfig = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
    };
  };

  environment.systemPackages = [
    inputs.wired-notify.packages.x86_64-linux.default
  ];
}
