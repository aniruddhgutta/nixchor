{ pkgs, lib, ... }:
# mirroring my dinit setup -
# https://codeberg.org/oceanicc/petrichor/src/branch/main/.config/dinit.d

let
  mkSvc = { exec, after ? [ ], wants ? after }: {
    inherit after;
    partOf = wants;
    wantedBy = wants;
    environment.PATH = lib.mkForce "/run/wrappers/bin:/run/current-system/sw/bin:/run/current-system/sw/sbin";
    serviceConfig = {
      ExecStart = exec;
      Restart = "always";
    };
  };
in
{
  systemd.user.services = {
    awww = mkSvc {
      exec = "${pkgs.awww}/bin/awww-daemon";
      wants = [ "graphical-session.target" ];
    };
    awww-backdrop = mkSvc {
      exec = "${pkgs.awww}/bin/awww-daemon --namespace backdrop";
      wants = [ "graphical-session.target" ];
    };
    foot = mkSvc {
      exec = "${pkgs.foot}/bin/foot --server";
      wants = [ "graphical-session.target" ];
    };
    mpd = mkSvc {
      exec = "${pkgs.mpd}/bin/mpd --no-daemon";
      wants = [ "default.target" ];
    };
    mpdris2-rs = mkSvc {
      exec = "${pkgs.mpdris2-rs}/bin/mpdris2-rs";
      after = [ "mpd.service" ];
    };
    mpdscribble = mkSvc {
      exec = "${pkgs.mpdscribble}/bin/mpdscribble --no-daemon";
      after = [ "mpd.service" ];
    };
    swayidle = mkSvc {
      exec = "${pkgs.swayidle}/bin/swayidle";
      wants = [ "graphical-session.target" ];
    };
    waybar = mkSvc {
      exec = "${pkgs.waybar}/bin/waybar";
      after = [ "dbus.service" "graphical-session.target" ];
    };
  };
}
