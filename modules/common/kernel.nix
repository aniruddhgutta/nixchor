{
  pkgs,
  ...
}:

{
  boot = {
    # kernel
    kernelPackages = pkgs.linuxPackages_latest;
    consoleLogLevel = 3;
    kernelParams = [ "nvme.noacpi=1" ];

    # enable sysrq
    kernel.sysctl."kernel.sysrq" = 1;

    # enable tmpfs
    tmp.useTmpfs = true;
  };

  # console color palette (mystbloom)
  console.colors = [
    "0E0E0E" "a3697d" "9aaa9e" "d1bea5" "9f8ac6" "cda2d4" "8a9ca0" "c7c9cc"
    "3d3744" "b8869b" "a8b8a8" "d8c5a0" "b8a4de" "d2aece" "a0b4b8" "eeeeee"
  ];

  services = {
    # configure logging
    journald.settings.Journal.SystemMaxUse = "50M";
    logrotate.enable = false;

    # enable earlyoom
    earlyoom = {
      enable = true;
      extraArgs = [
        "-r"
        "3600"
      ];
    };

  };

  # enable zram
  zramSwap.enable = true;
}
