{
  pkgs,
  ...
}:

{
  fonts = {
    packages = with pkgs; [
      # custom
      iosevka
      nerd-fonts.symbols-only

      # defaults
      dejavu_fonts
      liberation_ttf
      noto-fonts-color-emoji
    ];

    fontconfig = {
      enable = true;
      allowBitmaps = true;
      defaultFonts.monospace = [
        "Iosevka"
        "Symbols Nerd Font"
      ];
    };

  };
}
