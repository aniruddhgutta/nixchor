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
    "thunderbolt"
    "nvme"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/22ffdaac-0c73-4fc0-a156-1310775a4864";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/22ffdaac-0c73-4fc0-a156-1310775a4864";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/22ffdaac-0c73-4fc0-a156-1310775a4864";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/E4DB-A40C";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    "/media/windows" = {
      device = "/dev/disk/by-uuid/029AE0D39AE0C46F";
      fsType = "ntfs3";
      options = [
        "rw"
        "uid=1000"
        "gid=100"
        "nofail"
      ];
    };
  };

  swapDevices = [ ];
}
