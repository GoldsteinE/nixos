{ inputs, root, ... }: {
  imports = [
    inputs.ln-s.nixosModules.default
  ];

  classified.files = {
    "miniflux.env".encrypted = "${root}/secrets/metal/miniflux.env";
  };

  services.miniflux = {
    enable = true;
    config = {
      LISTEN_ADDR = "localhost:4755";
      BASE_URL = "https://rss.goldstein.rs/";
    };
    adminCredentialsFile = "/var/secrets/miniflux.env";
  };

  services.ln-s.enable = true;
  services.immich.enable = true;
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
        "photos.goldstein.lol" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          # stolen from https://git.sandwitch.dev/sand-witch/nixos/src/commit/3dd5ceb5564e22791d8f75bf4805fa691a2bc39b/metal/services/immich.nix
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:2283";
          locations."/".extraConfig = ''
            # allow large file uploads
            client_max_body_size 50000M;

            # Set headers
            proxy_set_header Host              $host;
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;

            # enable websockets: http://nginx.org/en/docs/http/websocket.html
            proxy_http_version 1.1;
            proxy_set_header   Upgrade    $http_upgrade;
            proxy_set_header   Connection "upgrade";
            proxy_redirect     off;

            # set timeout
            proxy_read_timeout 600s;
            proxy_send_timeout 600s;
            send_timeout       600s;
          '';
        };
        "ln-s.sh" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = rootHeaders;
          locations."/".proxyPass = "http://unix:/run/ln-s/ln-s.sock";
        };
      };
    };
}
