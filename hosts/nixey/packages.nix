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
    (symlinkJoin {
      name = "blender-oneapi";
      paths = [ blender-oneapi ];
      nativeBuildInputs = [ makeWrapper ];
      postBuild = "wrapProgram $out/bin/blender --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib";
    })

    # misc apps
    brave-origin
    gnome-calculator
    aerc
    senpai
    anki
  ];
}
