{
  pkgs,
  ...
}:

{
  fonts = {
    packages = with pkgs; [
      # defaults
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      # monospace
      iosevka
      nerd-fonts.symbols-only
    ];

    fontconfig.enable = true;
  };
}
