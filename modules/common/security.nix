{
  modules,
  lib,
  pkgs,
  ...
}:

{
  imports = with modules; [
    doas
    polkit
  ];

  # configure doas
  programs.doas = {
    enable = true;
    keepEnv = true;
    persist = true;
  };

  # enable polkit
  services.polkit.enable = true;

  # configure gnupg
  environment = {
    systemPackages = with pkgs; [
      gnupg
      pinentry-curses
    ];

    # use pinentry-curses
    etc."gnupg/gpg-agent.conf".text = "pinentry-program ${lib.getExe pkgs.pinentry-curses}\n";
  };
}
