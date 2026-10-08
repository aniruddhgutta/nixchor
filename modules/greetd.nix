{
  lib,
  pkgs,
  ...
}:

{
  # configure greetd with tuigreet
  services.greetd = {
    enable = true;
    useTextGreeter = true;

    settings.default_session.command = lib.escapeShellArgs [
      "${pkgs.tuigreet}/bin/tuigreet" "-t" "-r"
      "--power-shutdown" "systemctl poweroff"
      "--power-reboot" "systemctl reboot"
      "--theme" "border=magenta;text=cyan;prompt=cyan;time=blue;action=blue;button=yellow;container=black;input=green"
    ];
  };
}
