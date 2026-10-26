{
  modules,
  ...
}:

{
  imports = with modules; [ tuigreet ];
  # note: tuigreet imports greetd

  # configure tuigreet
  programs.tuigreet = {
    enable = true;
    extraArgs = [
      "-t" "-r"
      "--theme" "border=magenta;text=cyan;prompt=cyan;time=blue;action=blue;button=yellow;container=black;input=green"
    ];
  };

  # needed for tuigreet to work
  finit.runlevel = 3;
}
