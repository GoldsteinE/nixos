{ inputs, root, ... }: {
  classified.files = {
    "miniflux.env".encrypted = "${root}/secrets/metal/miniflux.env";
    "hedgedoc.env".encrypted = "${root}/secrets/metal/hedgedoc.env";
  };

  services.miniflux = {
    enable = true;
    config.LISTEN_ADDR = "localhost:4755";
    adminCredentialsFile = "/var/secrets/miniflux.env";
  };

  services.hedgedoc = rec {
    enable = true;
    workDir = "/srv/hedgedoc";
    environmentFile = "/var/secrets/hedgedoc.env";
    settings = {
      uploadsPath = "${workDir}/uploads";
      port = 44444;
      domain = "docs.goldstein.rs";
      allowAnonymous = false;
      allowAnonymousEdits = true;
      protocolUseSSL = true;
      db = {
        dialect = "sqlite";
        storage = "${workDir}/hedgedoc.sqlite";
      };
      github = {
        clientID = "$CMD_GITHUB_CLIENT_ID";
        clientSecret = "$CMD_GITHUB_CLIENTSECRET";
      };
    };
  };

  services.invidious = {
    enable = true;
    port = 1721;
    domain = "v.neglected.space";
  };

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
        "blog.goldstein.rs" = {
          root = "${inputs.blog.defaultPackage.x86_64-linux}";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = ''
            ${commonHeadersWithCsp}
            add_header X-Nix-Derivation ${inputs.blog.defaultPackage.x86_64-linux};
          '';
        };
        "inftheory.goldstein.rs" = {
          root = "${inputs.inftheory-slides.defaultPackage.x86_64-linux}";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeadersWithCsp;
          locations."/".index = "inftheory-slides.pdf";
        };
        "matrix.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:8008";
        };
        "nix.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          basicAuthFile = "/var/secrets/nix-serve-user";
          locations."/".proxyPass = "http://localhost:7174";
        };
        "docs.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:44444";
        };
        "rss.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:4755";
        };
        # Also auto-configured by `services.roundcube`
        "mail.goldstein.rs" = {
          enableACME = false;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
        };
      };
    };
}
