{ pkgs, ... }: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "root@goldstein.lol";
      base_url = "https://vault.goldstein.lol";
      lock_timeout = 1;
      # Use pass as a pinentry for rbw.
      pinentry = pkgs.writeScriptBin "pinentry" ''
        #!/bin/sh
        set -e

        echo "OK Pleased to meet you"
        read -r cmd
        while ! [ "$cmd" = "GETPIN" ]; do
            echo OK
            read -r cmd
        done
        printf 'D %s\n' "$(pass show vw-user)"
        echo OK
      '';
    };
  };
  home.packages = [
  (pkgs.writeScriptBin "bwp" ''
    #!/bin/sh
    set -e
    case "$1" in
      ls) rbw list --fields name,folder | grep -P pass | cut -f1 ;;
      fzf) bwp ls | fzf | xargs bwp show ;;
      show) rbw get --folder pass "$2" ;;
      *) bwp show "$1" ;;
    esac
  '')];
}
