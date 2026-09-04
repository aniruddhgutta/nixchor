{ config, lib, pkgs, ... }:

{
  # configure tlp and thermald, disable ppd
  services = {
    thermald.enable = true;
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        DISK_APM_LEVEL_ON_BAT = "128 128";
        AHCI_RUNTIME_PM_ON_BAT = "auto";
        PCIE_ASPM_ON_BAT = "powersupersave";
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        SOUND_POWER_SAVE_ON_BAT = 10;
        USB_AUTOSUSPEND = 1;
        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
