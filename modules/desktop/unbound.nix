{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = [ "127.0.0.1" "::1" ];
        verbosity = 1;
        tls-system-cert = "yes";
        domain-insecure = "mgt.";
      };
      forward-zone = [
        {
          name = "mgt.";
          forward-addr = [ "10.44.20.36" "10.44.20.128" ];
        }
        {
          name = ".";
          forward-addr = [
            "9.9.9.9@853#dns.quad9.net"
            "149.112.112.112@853#dns.quad9.net"
            "2620:fe::fe@853#dns.quad9.net"
            "2620:fe::9@853#dns.quad9.net"
          ];
          forward-tls-upstream = "yes";
        }
      ];
    };
  };
}
