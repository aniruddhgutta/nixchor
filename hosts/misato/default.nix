{
  modules,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    # finix modules
    modules.dhcpcd
  ];

  # enable microcode updates
  hardware.cpu.amd.updateMicrocode = true;

  # configuure dns
  services.dhcpcd.enable = true;
}
