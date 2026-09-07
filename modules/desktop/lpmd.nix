{ config, lib, pkgs, ... }:

let
  cfg = config.services.lpmd;
in
{
  options.services.lpmd = {
    enable = lib.mkEnableOption "Intel Low Power Mode Daemon";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.intel-lpmd;
      description = "intel-lpmd package to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.packages = [ cfg.package ];
    services.upower.enable = true;
    systemd.services.intel_lpmd = {
      wantedBy = [ "multi-user.target" ];
      # /run/intel_lpmd is tmpfs, gone every boot — systemd has to
      # (re)create it before ExecStart, not us.
      serviceConfig.RuntimeDirectory = "intel_lpmd";
    };
    services.dbus.packages = [ cfg.package ];
  };
}
