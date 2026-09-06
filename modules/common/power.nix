{ ... }:

{
  # configure tlp and thermald, disable ppd
  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        MEM_SLEEP_ON_PRF= "s2idle";
        MEM_SLEEP_ON_BAT= "s2idle";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;

        INTEL_GPU_POWER_PROFILE_ON_AC = "base";
        INTEL_GPU_POWER_PROFILE_ON_BAT = "power_saving";

        DISK_APM_LEVEL_ON_BAT = "128 128";
        AHCI_RUNTIME_PM_ON_BAT = "auto";
        PCIE_ASPM_ON_BAT = "powersupersave";

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "on";

        SOUND_POWER_SAVE_ON_BAT = 10;
        USB_AUTOSUSPEND = 1;
      };
    };
  };
}
