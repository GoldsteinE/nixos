{ ... }: {
  networking = {
    hostName = "think";
    dhcpcd.wait = "if-carrier-up";
    hosts = {
      "127.0.0.1" = [
        "requests.test"
      ];
      "163.172.167.207" = [
        "bt.t-ru.org"
        "bt2.t-ru.org"
        "bt3.t-ru.org"
        "bt4.t-ru.org"
      ];
    };
    networkmanager.enable = true;
    firewall.allowedUDPPorts = [ 51820 ];

    wg-quick.interfaces.wg0 = {
      autostart = false;
      privateKeyFile = "/var/secrets/mullvad.key";
      address = [
        "10.68.26.80/32"
        "fc00:bbbb:bbbb:bb01::5:1a4f/128"
      ];
      dns = [ "193.138.218.74" ];
      peers = [
        {
          publicKey = "Qn1QaXYTJJSmJSMw18CGdnFiVM0/Gj/15OdkxbXCSG0=";
          endpoint = "193.138.218.220:51820";
          allowedIPs = [
            "0.0.0.0/5"
            "8.0.0.0/7"
            "11.0.0.0/8"
            "12.0.0.0/6"
            "16.0.0.0/4"
            "32.0.0.0/3"
            "64.0.0.0/2"
            "128.0.0.0/3"
            "160.0.0.0/5"
            "168.0.0.0/6"
            "172.0.0.0/12"
            "172.32.0.0/11"
            "172.64.0.0/10"
            "172.128.0.0/9"
            "173.0.0.0/8"
            "174.0.0.0/7"
            "176.0.0.0/4"
            "192.0.0.0/9"
            "192.128.0.0/11"
            "192.160.0.0/13"
            "192.169.0.0/16"
            "192.170.0.0/15"
            "192.172.0.0/14"
            "192.176.0.0/12"
            "192.192.0.0/10"
            "193.0.0.0/9"
            "193.128.0.0/13"
            "193.136.0.0/15"
            "193.138.0.0/17"
            "193.138.128.0/18"
            "193.138.192.0/20"
            "193.138.208.0/21"
            "193.138.216.0/23"
            "193.138.218.0/25"
            "193.138.218.128/26"
            "193.138.218.192/28"
            "193.138.218.208/29"
            "193.138.218.216/30"
            "193.138.218.221/32"
            "193.138.218.222/31"
            "193.138.218.224/27"
            "193.138.219.0/24"
            "193.138.220.0/22"
            "193.138.224.0/19"
            "194.0.0.0/7"
            "196.0.0.0/6"
            "200.0.0.0/5"
            "208.0.0.0/4"
          ];
        }
      ];
    };
    wg-quick.interfaces.wg1 = {
      address = [ "172.16.0.2/20" ];
      privateKeyFile = "/var/secrets/srvr.key";
      listenPort = 51820;
      peers = [
        {
          publicKey = "IqSILmfZJvrEl+5nMrqshTSOI5xX61mAsFIPhn3m4i4=";
          endpoint = "194.163.129.129:51820";
          allowedIPs = [ "172.16.0.0/20" ];
        }
      ];
    };
  };
}
