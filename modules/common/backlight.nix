{
  modules,
  pkgs,
  ...
}:

# mirroring my dinit brightness restore implementation -
# https://codeberg.org/oceanicc/petrichor/src/branch/assets/usr/lib/dinit/backlight

let
  backlight = pkgs.writeShellScript "backlight" ''
    d=/var/cache/backlight
    mkdir -p "$d"
    for c in /sys/class/backlight/*; do
      [ -d "$c" ] || continue
      f=$d/''${c##*/}
      case $1 in
        start) read -r v < "$f" && [ "$v" -gt 0 ] && echo "$v" > "$c/brightness" ;;
        stop)  cat "$c/brightness" > "$f" ;;
      esac
    done
    :
  '';
in
{
  imports = [ modules.brightnessctl ];

  # enable brightnessctl
  programs.brightnessctl.enable = true;

  # restore brightness
  finit.tasks = {
    backlight-restore = {
      description = "restore backlight";
      command = "${backlight} start";
      remain-after-exit = true;
    };
    backlight-save = {
      description = "save backlight";
      command = "${backlight} stop";
      runlevel = "06";
    };
  };
}
