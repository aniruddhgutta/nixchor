{
  community,
  pkgs,
  ...
}:

{
  imports = [ community.intel-lpmd ];

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

  # enable intel-lpmd
  services.intel-lpmd.enable = true;

  # use proper speaker layout
  programs.modprobe.extraConfig = ''
    options snd-sof-intel-hda-generic hda_model=alc287-yoga9-bass-spk-pin
  '';

  boot = {
    # use 6.12-lts kernel to fix freezes
    # ref: https://gist.github.com/Blizzke/9bfc3efd835dd607df39cee9cdd7205c
    kernelPackages = pkgs.linuxPackages_6_12;

    kernelParams = [
      # force xe driver
      "i915.force_probe=!7d51"
      "xe.force_probe=7d51"

      # enable psr
      "xe.enable_psr=2"
    ];
  };

  services.udev.packages = [
    # workaround for intel be200 not waking up from sleep
    # ref: https://ratatoskr.run/linux-pci/2026/07/17301729/t
    (pkgs.writeTextDir "etc/udev/rules.d/60-be200-d3cold.rules" ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x272b", ATTR{d3cold_allowed}="0"
    '')

    # drop the unused O2 Micro SD reader (57:00.0): sdhci-pci keeps it and
    # root port 1c.0 in D0 even with no card, which blocks deep package c-states
    (pkgs.writeTextDir "etc/udev/rules.d/61-sdreader-remove.rules" ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1217", ATTR{device}=="0x8621", ATTR{remove}="1"
    '')
  ];

  # (for testing various freeze-related solutions)
  # programs.modprobe.blacklist = [ "iwlwifi" ];
  # environment.systemPackages = with pkgs; [
  #   linuxKernel.packages.linux_6_12.turbostat
  #   pciutils
  #   perf
  #   psmisc
  # ];
}
