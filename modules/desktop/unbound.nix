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
            "1.1.1.1@853#cloudflare-dns.com"
            "1.0.0.1@853#cloudflare-dns.com"
          ];
          forward-tls-upstream = "yes";
        }
      ];
    };
  };
}
