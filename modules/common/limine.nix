{
  modules,
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ modules.limine ];

  boot.loader.efi.canTouchEfiVariables = true;

  # configure limine
  programs.limine = {
    enable = true;
    maxGenerations = 10;

    settings = {
      # set timeout to 3 seconds
      timeout = 3;

      # theme limine
      wallpaper = [ ];
      interface_branding = "${config.networking.hostName}";
      interface_help_hidden = true;
      interface_branding_color    = "cda2d4";  # header
      interface_help_color        = "9aaa9e";  # countdown text and help keys
      interface_help_color_bright = "a8b8a8";  # countdown digits

      # color palette (mystbloom)
      term_palette        = "0E0E0E;a3697d;9aaa9e;d1bea5;9f8ac6;cda2d4;cda2d4;c7c9cc";
      term_palette_bright = "3d3744;b8869b;a8b8a8;d8c5a0;b8a4de;d2aece;a0b4b8;eeeeee";
      term_foreground     = "eeeeee";
      term_background     = "000E0E0E";

      # enable editor (when secureboot is disabled)
      editor_enabled = !config.programs.limine.secureBoot.enable;
    };

    # enable secureboot
    secureBoot = {
      enable = lib.mkDefault true;
      autoGenerateKeys = true;
      autoEnrollKeys.enable = true;
    };
  };

  environment.systemPackages = lib.mkIf config.programs.limine.secureBoot.enable [ pkgs.sbctl ];
}
