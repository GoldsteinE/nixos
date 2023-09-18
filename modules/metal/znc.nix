{ ... }: {
  services.znc = {
    enable = true;
    openFirewall = true;
    group = "certs";
    mutable = false;
    useLegacyConfig = false;
    config = {
      SSLCertFile = "/var/lib/acme/goldstein.rs/cert.pem";
      SSLKeyFile = "/var/lib/acme/goldstein.rs/key.pem";
      LoadModule = [ "adminlog" ];
      User.goldstein = {
        Admin = true;
        Nick = "GoldsteinQ";
        LoadModule = [ "chansaver" "controlpanel" ];
        Network.libera = {
          server = "irc.libera.chat +6697";
          LoadModule = [ "simple_away" "sasl" ];
          Chan = {
            "#nixos" = { Buffer = 10000; };
            "#haskell" = { Buffer = 10000; };
            "#ghc" = { Buffer = 10000; };
          };
        };
        Network.hackint = {
          server = "irc.hackint.org +6697";
          LoadModule = [ "simple_away" "sasl" ];
          Chan = {
            "#tvl" = { Buffer = 10000; };
          };
        };
        Pass.password = {
          Method = "sha256";
          Hash = "3a3c258d345b3f5f846d2672f3c68aa1a304e53c11c687d9f7a87f62db3ca016";
          Salt = "),e4am)9QSaG-cDjwaHK";
        };
      };
    };
  };
}
