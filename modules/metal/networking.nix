{ ... }: {
  networking = {
    hostName = "metal";
    useDHCP = true;
    firewall = {
      allowedTCPPorts = [ 7643 80 443 19423 31337 ];
    };
    interfaces.enp6s0.ipv6 = {
      addresses = [{
        address = "2a01:4f8:13b:f58::1";
        prefixLength = 64;
      }];
      routes = [{
        via = "fe80::1";
        address = "::";
        prefixLength = 0;
      }];
    };
  };
}
