{ config, root, ... }:
let
    hostname = config.networking.hostName;
    keyname = "tarsnap-${hostname}";
in {
  classified.files.${keyname}.encrypted = "${root}/secrets/${hostname}/tarsnap.key";
}
