{ inputs, pkgs, ... }:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.fridays = {
      enable = true;
      openFirewall = true;
      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.15.3";
      };
      symlinks = {
        "mods" = "/srv/minecraft/.minecraft/mods";
      };
      serverProperties = {
        online-mode = false;
        snooper-enabled = false;
        view-distance = 16;
        difficulty = 2;
        motd = "Rust Fridays: now in Minecraft!";
      };
    };
    servers.fridays-creative = {
      enable = true;
      openFirewall = true;
      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.15.3";
      };
      symlinks = {
        "mods" = "/srv/minecraft/.minecraft/mods";
      };
      serverProperties = {
        server-port = 25566;
        online-mode = false;
        snooper-enabled = false;
        view-distance = 16;
        gamemode = 1;
        motd = "Rust Fridays: now in Creative!";
      };
    };
  };
}
