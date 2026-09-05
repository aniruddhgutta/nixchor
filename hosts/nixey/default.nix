{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "nixey";
  system.stateVersion = "26.05";

  # configure intel-graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };
  hardware.enableRedistributableFirmware = true;

  # fix race conditions (fuck intel)
  boot.kernelParams = [
    "intel_idle.max_cstate=1"  # workaround for ideapad pro 5 black screening
    "pcie_port_pm=off"         # workaround for intel be200 not waking up from sleep
    "i915.force_probe=!7d51"   # force xe driver
    "xe.force_probe=7d51"
  ];
}
