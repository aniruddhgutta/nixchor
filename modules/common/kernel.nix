{
  modules,
  pkgs,
  ...
}:

{
  imports = with modules; [
    earlyoom
    sysklogd
    zram-swap
  ];

  # kernel
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "loglevel=3"
      "nvme.noacpi=1"
    ];

    # enable sysrq
    kernel.sysctl."kernel.sysrq" = 1;
  };

  # console color palette (mystbloom)
  hardware.console.colors = [
    "0E0E0E" "a3697d" "9aaa9e" "d1bea5" "9f8ac6" "cda2d4" "8a9ca0" "c7c9cc"
    "3d3744" "b8869b" "a8b8a8" "d8c5a0" "b8a4de" "d2aece" "a0b4b8" "eeeeee"
  ];

  services = {
    # enable logging
    sysklogd.enable = true;

    # enable earlyoom
    earlyoom = {
      enable = true;
      extraArgs = [
        "-r"
        "3600"
      ];
    };

    # enable zram
    zram-swap.enable = true;
  };
}
