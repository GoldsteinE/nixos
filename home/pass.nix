{ pass, pkgs, ... }: {
  programs.password-store = {
    enable = true;
    package = pass;
  };
  services.pass-secret-service.enable = true;
  # "fix" dbus-next
  # https://github.com/NixOS/nixpkgs/pull/360361
  services.pass-secret-service.package = pkgs.pass-secret-service.override {
    python3 = pkgs.python3.override {
      packageOverrides = (self: super: {
        dbus-next = super.dbus-next.overridePythonAttrs {
          doCheck = false;
        };
      });
    };
  };
}
