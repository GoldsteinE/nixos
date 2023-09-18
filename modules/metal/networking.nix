{ ... }: {
  networking = {
    hostName = "metal";
    useDHCP = true;
    firewall = {
      allowedTCPPorts = [ 7643 80 443 19423 ];
    };
  };
}
