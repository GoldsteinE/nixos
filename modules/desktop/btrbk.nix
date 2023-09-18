{ config, root, ... }: {
  classified.files.btrbk = {
    encrypted = "${root}/secrets/desktop-btrbk";
    user = "btrbk";
  };

  services.btrbk.instances.btrbk.settings = {
    ssh_user = "btrbk";
    ssh_identity = "/var/secrets/btrbk";
    volume."/" = {
      target = "ssh://goldstein.rs:7643/dump/backups/${config.networking.hostName}";
    };

    volume."/".subvolume = {
      etc = { };
      home = { };
    };
  };
}
