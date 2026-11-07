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

    # creative
    gimp
    ffmpeg-headless
    obs-studio
    davinci-resolve

    # misc apps
    # brave-origin
    gnome-calculator
    aerc
    senpai
  ];
}
