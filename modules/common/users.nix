{
  config,
  lib,
  pkgs,
  ...
}:

{
  users = {
    # set default shell to yash
    defaultUserShell = pkgs.yash;
    users.root.shell = lib.mkForce config.users.defaultUserShell;

    # configure vye
    users.vye = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "$6$dDxCpnNCQop.3zrK$zSdRUNsRD1QQHEpwlSxToMT5RQd2/0mJ0aLFUe7LJAI.9vXZ/SGQpnd5tRuSYN7UeCkIMXtXRjwVg3ypp3duh1";
    };
  };
}
