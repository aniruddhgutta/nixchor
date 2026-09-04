{ config, lib, pkgs, ... }:

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
    kernelParams = [
      "intel_idle.max_cstate=1"  # workaround for ideapad pro 5 black screening
      "pcie_port_pm=off"         # workaround for intel be200 not waking up from sleep
      "i915.force_probe=!7d51"   # force xe driver
      "xe.force_probe=7d51"
    ];
    consoleLogLevel = 3;
    kexec.enable = false;
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
