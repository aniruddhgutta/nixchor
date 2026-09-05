{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      jetbrains-mono
      cozette
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      enable = true;
      allowBitmaps = true;
      defaultFonts.monospace = [
        "Iosevka"
        "Cozette"
        "Jetbrains Mono"
        "Symbols Nerd Font"
      ];
    };

    fontDir.enable = true;
  };
}
