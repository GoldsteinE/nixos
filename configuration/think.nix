params: {
  imports = [
    ./desktop.nix
  ];

  classified.files."vpn.ovpn".encrypted = ./secrets/desktop/vpn.ovpn;
  services.openvpn.servers.work = {
    config = "config /var/secrets/vpn.ovpn";
    updateResolvConf = true;
  };
}
