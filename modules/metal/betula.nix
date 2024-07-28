# TODO: make a proper module
{ pkgs, ... }: {
  users.users.betula = {
    group = "nogroup";
    isSystemUser = true;
  };
  systemd.services.betula-links = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.betula}/bin/betula -port 4370 /srv/betula/links.betula";
      User = "betula";
      Group = "nogroup";
    };
  };
}

