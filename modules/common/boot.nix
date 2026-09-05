{ pkgs, ... }:

{
  boot = {
    # systemd-boot
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 10;
      };
    };

    # kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
    consoleLogLevel = 3;
    tmp.useTmpfs = true;
  };

  # console colors (mystbloom)
  console.colors = [
    "141416" "a3697d" "9aaa9e" "d1bea5" "9f8ac6" "cda2d4" "8a9ca0" "c7c9cc"
    "3d3744" "b8869b" "a8b8a8" "d8c5a0" "b8a4de" "d2aece" "a0b4b8" "eeeeee"
  ];

  # logging
  services.journald.extraConfig = "SystemMaxUse=50M";
  services.logrotate.enable = false;
}
