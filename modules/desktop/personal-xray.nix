{ root, pkgs, ... }:
  let xray-service = conf: description: {
    inherit description;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      DynamicUser = true;
      ExecStart = "${pkgs.xray}/bin/xray -config \${CREDENTIALS_DIRECTORY}/xray.json";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      NoNewPrivileges = true;
      LoadCredential = "xray.json:/var/secrets/${conf}";
    };
  }; in {
  classified.files = {
    "personal-xray.json".encrypted = "${root}/secrets/personal-xray.json";
    "personal-xray-il.json".encrypted = "${root}/secrets/personal-xray-il.json";
  };
  # todo: dedup with other xray?
  systemd.services.personal-xray = xray-service "personal-xray.json" "personal xray daemon";
  systemd.services.personal-xray-il = xray-service "personal-xray-il.json" "personal xray daemon (IL)";
}
