{
  _unflake = {
    dedupRules = [
      ({
        when = { type = "github"; owner = "nixos"; repo = "nixpkgs"; rev = null; };
        set = { ref = "nixos-unstable"; };
      })
    ];
  };

  fenix.url = "github:nix-community/fenix";
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  anti-emoji.url = "github:GoldsteinE/anti-emoji-bot";
  classified.url = "github:GoldsteinE/classified";
  home-manager.url = "github:nix-community/home-manager";
  inftheory-slides.url = "github:GoldsteinE/inftheory-slides";
  lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
  lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
  ln-s.url = "sourcehut:~goldstein/ln-s";
  naersk.url = "github:nmattia/naersk";
  nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  nixos-hardware.url = "github:NixOS/nixos-hardware";
  nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  passnag.url = "github:GoldsteinE/passnag";
  perlsub.url = "github:GoldsteinE/perlsub";
  r9ktg.url = "github:GoldsteinE/r9ktg";
  simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
  t.url = "github:GoldsteinE/flake-templates";
  tg-vimhelpbot.url = "github:pro-vim/tg-vimhelpbot";
  xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
}
