{ pkgs, ... }: {
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nix}/bin/nix store diff-closures /run/current-system "$systemConfig"
    '';
  };
}
