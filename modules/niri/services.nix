{
  pkgs,
  ...
}:

# mirroring my dinit setup -
# https://codeberg.org/oceanicc/petrichor/src/branch/main/.config/dinit.d

{
  imports = [ ../dinit.nix ];

  dinit = {
    enable = true;
    user.services = {
      awww = {
        type = "process";
        command = "${pkgs.awww}/bin/awww-daemon";
        log-type = "buffer";
      };
      awww-backdrop = {
        type = "process";
        command = "${pkgs.awww}/bin/awww-daemon --namespace backdrop";
        log-type = "buffer";
      };
      foot = {
        type = "process";
        command = "${pkgs.foot}/bin/foot --server";
      };
      mpd = {
        type = "process";
        command = "${pkgs.mpd}/bin/mpd --no-daemon";
        restart = true;
        smooth-recovery = true;
      };
      mpdris2-rs = {
        type = "process";
        command = "${pkgs.mpdris2-rs}/bin/mpdris2-rs";
        depends-on = [ "mpd" ];
        restart = true;
      };
      mpdscribble = {
        type = "process";
        command = "${pkgs.mpdscribble}/bin/mpdscribble --no-daemon";
        depends-on = [ "mpd" ];
        restart = true;
      };
      swayidle = {
        type = "process";
        command = "${pkgs.swayidle}/bin/swayidle";
        log-type = "buffer";
      };
      waybar = {
        type = "process";
        command = "${pkgs.waybar}/bin/waybar";
      };
    };

  };
}
