{ root, ... }: {
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
  services.xray = {
    enable = true;
    settingsFile = "\${CREDENTIALS_DIRECTORY}/xray.json";
  };
  systemd.services.xray.serviceConfig = {
    LoadCredential = "xray.json:/var/secrets/work-vpn-xray.json";
  };
}
