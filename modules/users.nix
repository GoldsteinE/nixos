{ pkgs, ... }:
let
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFfvajQ3g5zDNGlGFfMrK9X1v4o5TBsSkP55KGn69Z4T goldstein@think"
  ];
in
{
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      goldstein = {
        createHome = true;
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" ];
        home = "/home/goldstein";
        shell = "/run/current-system/sw/bin/zsh";
        openssh.authorizedKeys.keys = sshKeys;
      };
      root.openssh.authorizedKeys.keys = sshKeys;
    };
  };
}
