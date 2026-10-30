{
  modules,
  pkgs,
  ...
}:

{
  imports = with modules; [
    earlyoom
    sysklogd
    zram-swap
  ];

  # kernel
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "loglevel=3"
      "nvme.noacpi=1"

      # console color palette (mystbloom)
      "vt.default_red=20,163,154,209,159,205,138,199,61,184,168,216,184,210,160,238"
      "vt.default_grn=20,105,170,190,138,162,156,201,55,134,184,197,164,174,180,238"
      "vt.default_blu=22,125,158,165,198,212,160,204,68,155,168,160,222,206,184,238"
    ];

    # rescue
    kernel.sysctl."kernel.sysrq" = 1;
    initrd.emergencyAccess = true;
  };

  services = {
    # enable logging
    sysklogd = {
      enable = true;
      extraConfig = ''
        rotate_size  1M
        rotate_count 5
      '';
    };

    # enable earlyoom
    earlyoom = {
      enable = true;
      extraArgs = [ "-r" "3600" ];
    };

    # enable zram
    zram-swap.enable = true;
  };
}
