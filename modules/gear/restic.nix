{ root, pkgs, ... }: {
  classified.files = {
    "backup-b2.env".encrypted = "${root}/secrets/gear/backup-b2.env";
    "backup-restic-pass".encrypted = "${root}/secrets/gear/backup-restic-pass";
  };

  services.restic.backups.gear = {
    timerConfig = {
      OnCalendar = "01:05";
      Persistent = true;
    };
    runCheck = true;
    repository = "s3:https://s3.eu-central-003.backblazeb2.com/backup-gear";
    paths = [ "/home.snap" ];
    exclude = [
      "/home.snap/goldstein/local/share/containers"
      "/home.snap/goldstein/local/share/Steam"
      "/home.snap/goldstein/.cargo/git"
      "/home.snap/goldstein/.cargo/registry"
    ];
    extraBackupArgs = [ "--verbose" ];
    inhibitsSleep = true;
    passwordFile = "/var/secrets/backup-restic-pass";
    environmentFile = "/var/secrets/backup-b2.env";
    backupPrepareCommand = "${pkgs.btrfs-progs}/bin/btrfs subvolume snapshot /home /home.snap";
    backupCleanupCommand = "${pkgs.btrfs-progs}/bin/btrfs subvolume delete /home.snap";
  };
}
