{
  community,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ community.dinit ];

  options.dinit.enable = lib.mkEnableOption "dinit user services";

  config = lib.mkIf config.dinit.enable {
    environment.systemPackages = [
      (lib.hiPrio pkgs.finit)
      pkgs.dinit
    ];

    dinit.user.services.boot = {
      type = "internal";
      waits-for = lib.attrNames (
        lib.filterAttrs (n: s: n != "boot" && s.enable) config.dinit.user.services
      );
    };
  };
}
