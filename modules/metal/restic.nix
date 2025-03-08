{ root, ... }: {
  classified.files = {
    "backup-b2.env".encrypted = "${root}/secrets/metal/backup-b2.env";
    "backup-restic-pass".encrypted = "${root}/secrets/metal/backup-restic-pass";
  };

  services.restic.backups.metal = {
    timerConfig = {
      OnCalendar = "01:05";
      Persistent = true;
    };
    runCheck = true;
    repository = "s3:https://s3.eu-central-003.backblazeb2.com/backup-metal";
    paths = [ "/srv" ];
    exclude = [ "/srv/minecraft" "/srv/satisfactory*" ];
    extraBackupArgs = [ "--verbose" ];
    passwordFile = "/var/secrets/backup-restic-pass";
    environmentFile = "/var/secrets/backup-b2.env";
  };
}

