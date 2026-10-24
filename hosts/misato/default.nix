{
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.05";

  # enable microcode updates
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  # configuure dns
  networking.dhcpcd.enable = true;
}
