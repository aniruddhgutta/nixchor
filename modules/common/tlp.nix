{
  modules,
  ...
}:

{
  imports = [ modules.tlp ];

  # configure tlp
  services.tlp = {
    enable = true;

    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_BAT = "low-power";

      INTEL_GPU_POWER_PROFILE_ON_BAT = "power_saving";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

      SOUND_POWER_SAVE_ON_BAT = 1;
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = [ "bluetooth" ];

      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersupersave";
    };
  };

  # use tlp without a password
  environment.etc."doas.conf".text = "permit nopass :wheel cmd tlp\n";
}
