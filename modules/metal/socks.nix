{ ... }: {
  users = {
    users.socks = {
      isSystemUser = true;
      group = "nogroup";
    };
  };
  services.dante = {
    enable = true;
    config = ''
      internal: enp6s0 port = 19423
      external: enp6s0
      socksmethod: username
      client pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        log: error
        socksmethod: username
      }
      socks pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        command: bind connect udpassociate
        log: error connect disconnect
        socksmethod: username
      }
      socks pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        command: bindreply udpreply
        log: error connect disconnect
      }
    '';
  };
}
