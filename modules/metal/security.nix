{ pkgs, ... }: {
  classified.keys.default = "/classified.key";
  security.pam.sshAgentAuth = {
    enable = true;
  };
  services = {
    openssh = {
      enable = true;
      ports = [ 7643 ];
      settings.GatewayPorts = "clientspecified";
      authorizedKeysFiles = pkgs.lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
    };

    btrbk.sshAccess = [{
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB42VmC3wPITh7koYvslYPS4GHQEA1ZlNcWaCaqzqlGS goldstein@think";
      roles = [ "info" "source" "target" "snapshot" "send" "receive" ];
    }];
  };
}
