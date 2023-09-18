{ inputs, system, root, ... }: {
  imports = [
    inputs.anti-emoji.nixosModules."${system}".default
    inputs.r9ktg.nixosModules."${system}".default
    inputs.perlsub.nixosModules."${system}".default
    inputs.tg-vimhelpbot.nixosModules."${system}".default
  ];
  classified.files = {
    "emoji-bot.env".encrypted = "${root}/secrets/metal/emoji-bot.env";
    "r9ktg.env".encrypted = "${root}/secrets/metal/r9ktg.env";
    "tg-vimhelpbot.env".encrypted = "${root}/secrets/metal/tg-vimhelpbot.env";
    "perlsub.env" = {
      encrypted = "${root}/secrets/metal/perlsub.env";
      user = "perlsub";
    };
  };
  systemd.services.classified.before = [
    "r9ktg.service"
    "perlsub.service"
    "emojiBot.service"
  ];
  systemd.targets.network.before = [
    "r9ktg.service"
    "perlsub.service"
    "emojiBot.service"
    "tg-vimhelpbot.service"
  ];

  services = {
    emojiBot = {
      enable = true;
      envFile = "/var/secrets/emoji-bot.env";
    };
    r9ktg = {
      enable = true;
      envFile = "/var/secrets/r9ktg.env";
    };
    perlsub = {
      enable = true;
      envFile = "/var/secrets/perlsub.env";
    };
    tg-vimhelpbot = {
      enable = true;
      envFile = "/var/secrets/tg-vimhelpbot.env";
    };
  };
}
