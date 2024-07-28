{ root, ... }: {
  classified.files."matrix.key" = {
    encrypted = "${root}/secrets/metal/matrix.key";
    user = "matrix-synapse";
  };
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "tty5.dev";
      public_baseurl = "https://matrix.tty5.dev/";
      url_preview_enabled = false;
      signing_key_path = "/var/secrets/matrix.key";
      dynamic_thumbnails = true;
      # listens on port 8008 by default
    };
  };
}
