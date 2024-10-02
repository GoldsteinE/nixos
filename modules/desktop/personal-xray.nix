{ root, pkgs, ... }: {
  classified.files = {
    "personal-xray.json".encrypted = "${root}/secrets/personal-xray.json";
  };
  # todo: dedup with other xray?
  systemd.services.personal-xray = {
    description = "personal xray daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      DynamicUser = true;
      ExecStart = "${pkgs.xray}/bin/xray -config \${CREDENTIALS_DIRECTORY}/xray.json";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      NoNewPrivileges = true;
      LoadCredential = "xray.json:/var/secrets/personal-xray.json";
    };
  };
}
