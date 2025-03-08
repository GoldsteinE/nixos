{ pkgs, ... }: {
  environment.wordlist.enable = true;
  environment.systemPackages = with pkgs; [
    bat
    curl
    difftastic
    dogdns
    fd
    file
    git
    htop
    gh
    jq
    killall
    man-pages
    ncdu
    neovim
    pwgen
    powertop
    python3
    ripgrep
    nixd
    nixpkgs-fmt
    shellcheck
    unzip
    vim
    wget
    zip
  ];
}
