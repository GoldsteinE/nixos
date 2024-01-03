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
        motd = "Rust Fridays: now in Minecraft!";
      };
    };
  };
}
