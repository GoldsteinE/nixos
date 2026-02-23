{ ... }: {
  networking = {
    hostName = "metal";
    useDHCP = true;
    firewall = {
      allowedTCPPorts = [ 7643 80 443 19423 31337 31338 ];
    };
    nameservers = [
      "9.9.9.9"
      "2620:fe::fe"
    ];
    interfaces.enp6s0 = {
      ipv6 = {
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
      ipv4 = {
        addresses = [{
          address = "195.201.8.234";
          prefixLength = 26;
        }];
        routes = [{
          via = "195.201.8.193";
          address = "0.0.0.0";
          prefixLength = 0;
        }];
      };
    };
  };
}
