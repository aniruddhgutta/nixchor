{
  config,
  lib,
  ...
}:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;

    # configure limine
    limine = {
      enable = true;
      maxGenerations = 7;

      # theme limine
      style = {
        wallpapers = [ ];
        interface = {
          branding = "${config.networking.hostName}";
          helpHidden = true;
          brandingColor   = "cda2d4";  # header
          helpColor       = "9aaa9e";  # countdown text and help keys
          helpColorBright = "a8b8a8";  # countdown digits
        };

        # color palette (mystbloom)
        graphicalTerminal = {
          palette       = "0E0E0E;a3697d;9aaa9e;d1bea5;9f8ac6;cda2d4;cda2d4;c7c9cc";
          brightPalette = "3d3744;b8869b;a8b8a8;d8c5a0;b8a4de;d2aece;a0b4b8;eeeeee";
          foreground    = "eeeeee";
          background    = "000E0E0E";
        };
      };

      # enable secureboot
      secureBoot = {
        enable = lib.mkDefault true;
        autoGenerateKeys = true;
        autoEnrollKeys.enable = true;
      };
    };
  };
}
