{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    clang
    curl
    difftastic
    # dogdns
    fd
    file
    gcc
    git
    htop
    gh
    jq
    killall
    man-pages
    mold
    ncdu
    neovim
    pwgen
    python3
    ripgrep
    nil
    nixpkgs-fmt
    shellcheck
    unzip
    vim
    wget
    zip
  ];
}
