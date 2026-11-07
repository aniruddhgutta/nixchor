{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # cli
    android-tools

    # dev
    gnumake
    clang
    clang-tools

    # text editors
    kakoune
    neovim

    # creative
    gimp
    ffmpeg-headless
    obs-studio
    davinci-resolve

    # misc apps
    helium
    gnome-calculator
    aerc
    senpai
  ];
}
