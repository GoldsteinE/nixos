{ inputs, root, ... }: {
  imports = [
    inputs.ln-s.nixosModules.default
  ];

  classified.files = {
    "miniflux.env".encrypted = "${root}/secrets/metal/miniflux.env";
  };

  services.miniflux = {
    enable = true;
    config.LISTEN_ADDR = "localhost:4755";
    adminCredentialsFile = "/var/secrets/miniflux.env";
  };

  services.invidious = {
    enable = true;
    port = 1721;
    domain = "v.neglected.space";
    settings.db.user = "invidious";
  };

  services.ln-s.enable = true;
  systemd.services.ln-s.serviceConfig = {
    MemoryHigh = "64M";
    MemoryMax = "128M";
    CPUQuota = "5%";
  };
  users.users.nginx.extraGroups = [ "ln-s" ];

  services.nginx =
    let
      commonHeadersWithoutHsts = ''
        add_header X-Hi 'to anyone reading raw HTTP :)';
        add_header X-Clacks-Overhead 'GNU Terry Pratchett';
        add_header X-Frame-Options SAMEORIGIN;
        add_header X-Content-Type-Options nosniff;
        add_header Referrer-Policy strict-origin-when-cross-origin;
      '';
      commonHeaders = commonHeadersWithoutHsts + "\n" + ''
        add_header Strict-Transport-Security max-age=31536000;
      '';
      csp = ''
        add_header Content-Security-Policy "default-src 'self'; base-uri 'none'; frame-ancestors 'self'; connect-src https://goldstein.rs https://*.goldstein.rs 'self'; plugin-types; object-src 'none'; style-src 'self' 'unsafe-inline' 'unsafe-eval';";
      '';
      commonHeadersWithCsp = commonHeaders + "\n" + csp;
      rootHeaders = commonHeadersWithoutHsts + "\n" + csp + "\n" + ''
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload";
      '';
    in
    {
      enable = true;
      enableReload = true;
      group = "certs";
      appendHttpConfig = ''
        ssl_stapling on; 
        ssl_session_cache shared:SSL:5m;
        sendfile on;
        gzip on;
        gzip_proxied any;
        gzip_types
          text/css
          text/javascript
          text/xml
          text/plain
          text/html;
      '';
      recommendedProxySettings = true;

      virtualHosts = {
        "goldstein.rs" = {
          root = "/srv/root";
          default = true;
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = rootHeaders;
          locations."/.well-known/webfinger/" = {
            index = "index.json";
          };
        };
        "neglected.space" = {
          root = "/srv/neglected";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = rootHeaders;
        };
        "v.neglected.space" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:1721";
        };
        "tty5.dev" = {
          root = "/srv/root";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/.well-known/matrix/server".return = ''200 '{"m.server":"matrix.tty5.dev:443"}' '';
          locations."/.well-known/matrix/client".return = ''200 '{"m.homeserver":{"base_url":"https://matrix.tty5.dev/"}}' '';
        };
        "matrix.tty5.dev" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:8008";
        };
        "inftheory.goldstein.rs" = {
          root = "${inputs.inftheory-slides.defaultPackage.x86_64-linux}";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeadersWithCsp;
          locations."/".index = "inftheory-slides.pdf";
        };
        "nix.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          basicAuthFile = "/var/secrets/nix-serve-user";
          locations."/".proxyPass = "http://localhost:7174";
        };
        "rss.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:4755";
        };
        "links.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:4370";
          locations."/favicon.ico".root = "/srv/betula";
        };
        "vault.goldstein.lol" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:54717";
        };
        "ln-s.sh" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = rootHeaders;
          locations."/".proxyPass = "http://unix:/run/ln-s/ln-s.sock";
        };
        # Also auto-configured by `services.roundcube`
        "mail.goldstein.rs" = {
          enableACME = false;
          useACMEHost = "goldstein.rs";
        };
      };
    };
}
