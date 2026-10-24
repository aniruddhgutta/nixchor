{
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "ahci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/055e9e45-6105-4766-8bd9-b08895e955ac";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/055e9e45-6105-4766-8bd9-b08895e955ac";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/055e9e45-6105-4766-8bd9-b08895e955ac";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/1359-2564";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  swapDevices = [ ];
}
