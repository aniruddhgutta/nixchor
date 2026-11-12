{
  modules,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (with modules; [
    dhcpcd
    earlyoom
    zram-swap
  ]);

  # enable microcode updates
  hardware.cpu.amd.updateMicrocode = true;

  # enable dhcpcd
  services.dhcpcd.enable = true;

  services = {
    # enable earlyoom
    earlyoom = {
      enable = true;
      extraArgs = [
        "-r"
        "3600"
      ];
    };

    # enable zram
    zram-swap.enable = true;
  };
}
