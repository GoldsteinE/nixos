{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    curl
    difftastic
    dogdns
    fd
    gcc
    git
    htop
    hub
    jq
    killall
    man-pages
    ncdu
    neovim-nightly
    pwgen
    python3
    ripgrep
    rnix-lsp
    unzip
    vim
    wget
    zip
  ];
}
