{ ... }: {
  classified.keys.default = "/classified.key";
  security.pam.enableSSHAgentAuth = true;
  services = {
    openssh = {
      enable = true;
      ports = [ 7643 ];
      settings.GatewayPorts = "clientspecified";
    };

    btrbk.sshAccess = [{
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB42VmC3wPITh7koYvslYPS4GHQEA1ZlNcWaCaqzqlGS goldstein@think";
      roles = [ "info" "source" "target" "snapshot" "send" "receive" ];
    }];
  };
}
