{
  pkgs,
  ...
}:

{
  # configure intel hardware
  hardware = {
    # enable microcode upates
    cpu.intel.updateMicrocode = true;

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

  # use proper speaker layout
  programs.modprobe.extraConfig = ''
    options snd-sof-intel-hda-generic hda_model=alc287-yoga9-bass-spk-pin
  '';

  boot = {
    # use 6.12-lts kernel to fix freezes
    # ref: https://gist.github.com/Blizzke/9bfc3efd835dd607df39cee9cdd7205c
    kernelPackages = pkgs.linuxPackages_6_12;

    # various fixes
    kernelParams = [
      # workaround for ideapad pro 5 black screening
      # alt: use kernels <= 6.12-lts
      # "intel_idle.max_cstate=1"

      # workaround for intel be200 not waking up from sleep
      # alt: elogind hook to unload and reload iwlwifi module
      "pcie_port_pm=off"

      # force xe driver, since it's better suited for intel-arc gpus
      "i915.force_probe=!7d51"
      "xe.force_probe=7d51"
    ];
  };

  # (for testing various freeze-related solutions)
  # programs.modprobe.blacklist = [ "iwlwifi" ];
  # environment.systemPackages = [ pkgs.pciutils ];
}
