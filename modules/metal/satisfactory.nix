{ pkgs, ... }:
{
  virtualisation.oci-containers.containers.satisfactory = {
    image = "wolveix/satisfactory-server";
    hostname = "satisfactory-server";
    volumes = [ "/srv/satisfactory:/config" ];
    ports = [
      "7777:7777/udp"
      "15000:15000/udp"
      "15777:15777/udp"
    ];
    environment = {
      MAXPLAYERS = "8";
      PGID = "65534"; # nogroup
      PUID = "984"; # satisfactory
      ROOTLESS = "false";
      STEAMBETA = "false";
    };
  };
  users.users.satisfactory = {
    uid = 984;
    isSystemUser = true;
    isNormalUser = false;
    group = "nogroup";
  };
  networking.firewall.allowedUDPPorts = [ 7777 15000 15777 ];
}
