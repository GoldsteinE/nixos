{ ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      # It doesn't actually help anyway and it significantly worsens UX.
      "privacy.resistFingerprinting" = false;
    };
  };
}
