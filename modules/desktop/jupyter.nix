{ pkgs, ... }: {
  config = {
    users = {
      users.jupyter.group = "jupyter";
      groups.jupyter = { };
    };
    services.jupyter = {
      enable = true;
      password = "'argon2:$argon2id$v=19$m=10240,t=10,p=8$vPt9rj4Qc36onlIsYYvvjg$UzaiqESRgk3oyjROIDMBDET1dlVxS5V1XDYYPxRxq9A'";
      kernels = {
        python3 =
          let
            env = (pkgs.python3.withPackages (p: with p; [
              ipykernel
              numpy
              pandas
              pygal
              lxml
              cairosvg
              matplotlib
              tqdm
              networkx
              requests
            ]));
          in
          {
            displayName = "Python 3";
            argv = [
              "${env.interpreter}"
              "-m"
              "ipykernel_launcher"
              "-f"
              "{connection_file}"
            ];
            language = "python";
          };
      };
    };
  };
}
