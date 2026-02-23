{ pkgs, root, ... }: {
  systemd.user.timers.bell = {
    Unit.Description = "a regularly scheduled bell sound";
    Install.WantedBy = [ "graphical-session.target" ];
    Timer.OnCalendar = "*-*-* *:00,45:00";
  };
  systemd.user.services.bell = {
    Unit.Description = "play a bell sound";
    Service = {
      Type = "oneshot";
      ExecStart = let app = pkgs.writeShellApplication {
        name = "bell";
        runtimeInputs = with pkgs; [ mpv gnugrep ];
        text = ''
          grep open /proc/acpi/button/lid/LID0/state \
            && mpv --no-audio-display ${./bell.mp3} \
            || true
        '';
      }; in "${app}/bin/bell";
    };
  };
}
