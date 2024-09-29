{ ... }: {
  wayland.windowManager.sway = {
    extraOptions = [ "--unsupported-gpu" ];
    extraSessionCommands = ''
      export LIBVA_DRIVER_NAME=nvidia
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export WLR_NO_HARDWARE_CURSORS=1
    '';
  };
}
