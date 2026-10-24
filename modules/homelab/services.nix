{
  lib,
  pkgs,
  ...
}:

{
  systemd.services = {
    duckdns = {
      startAt = "*:0/5";
      serviceConfig.Type = "oneshot";
      script = ''${lib.getExe pkgs.curl} -fsS "https://www.duckdns.org/update?domains=vye&token=$(cat /etc/duckdns-token)&ip="'';
    };

    screen-dim = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "oneshot";
      script = "echo 5 | tee /sys/class/backlight/*/brightness";
    };
  };
}
