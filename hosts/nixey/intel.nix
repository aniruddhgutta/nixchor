{
  lib,
  pkgs,
  ...
}:

{
  imports = [ ../../pkgs/intel-lpmd/module.nix ];

  # configure intel hardware
  hardware = {
    enableRedistributableFirmware = true;

    # cpu/npu
    cpu.intel = {
      npu.enable = true;
      updateMicrocode = true;
    };

    # arc-igpu
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
        intel-compute-runtime
      ];
    };
  };

  # enable intel-lpmd's overlay
  nixpkgs.overlays = [
    (final: prev: {
      intel-lpmd = final.callPackage ../../pkgs/intel-lpmd/package.nix { };
    })
  ];
  services.lpmd.enable = lib.mkDefault false;

  # fix race conditions (fuck intel)
  boot.kernelParams = [
    "intel_idle.max_cstate=1" # workaround for ideapad pro 5 black screening
    "pcie_port_pm=off"        # workaround for intel be200 not waking up from sleep
    "i915.force_probe=!7d51"  # force xe driver
    "xe.force_probe=7d51"
  ];
}
