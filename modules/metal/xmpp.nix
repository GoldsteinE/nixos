{ ... }: {
  networking.firewall.allowedTCPPorts = [ 5280 5281 5222 5269 8010 ];
  services.prosody = {
    enable = true;
    group = "certs";
    admins = [ "goldstein@tty5.dev" ];
    virtualHosts.goldstein-lol = {
      enabled = true;
      domain = "tty5.dev";
    };
    ssl = {
      key = "/var/lib/acme/goldstein.rs/key.pem";
      cert = "/var/lib/acme/goldstein.rs/cert.pem";
    };
    muc = [{
      name = "max’s chats";
      domain = "chats.tty5.dev";
      maxHistoryMessages = 1000000;
      moderation = true;
      restrictRoomCreation = true;
      roomDefaultHistoryLength = 1000000;
      roomDefaultMembersOnly = true;
      roomDefaultModerated = true;
    }];
    modules = {
      websocket = true;
      announce = true;
      watchregistrations = true;
    };
    httpFileShare = {
      expires_after = "never";
      domain = "chats.tty5.dev";
    };
    extraConfig = ''
      archive_expires_after = "never"
    '';
  };
  services.movim = {
    port = 6302;
    enable = true;
    domain = "movim.tty5.dev";
    precompressStaticFiles = {
      gzip.enable = true;
      brotli.enable = true;
    };
    podConfig.xmppdomain = "tty5.dev";
    nginx = {
      useACMEHost = "goldstein.rs";
      forceSSL = true;
    };
  };
}
