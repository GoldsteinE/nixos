{ root, pkgs, ... }: {
  classified.files = {
    "work-vpn.ovpn".encrypted = "${root}/secrets/work-vpn.ovpn";
    "work-vpn-ovpn.pass".encrypted = "${root}/secrets/work-vpn-ovpn.pass";
    "work-vpn-xray.json".encrypted = "${root}/secrets/work-vpn-xray.json";
  };
  services.openvpn.servers.work = {
    config = "config /var/secrets/work-vpn.ovpn";
    updateResolvConf = true;
  };
  systemd.services.openvpn-work.requires = [ "xray.service" ];
  systemd.services.xray = {
    description = "xray daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      DynamicUser = true;
      ExecStart = "${pkgs.xray}/bin/xray -config \${CREDENTIALS_DIRECTORY}/xray.json";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      NoNewPrivileges = true;
      LoadCredential = "xray.json:/var/secrets/work-vpn-xray.json";
    };
  };
}
