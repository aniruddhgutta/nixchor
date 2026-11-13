{
  modules,
  community,
  inputs,
  ...
}:

{
  imports = [
    modules.nix-daemon
    community.nh
  ];
  # note: no benefits to using lix as of now

  services.nix-daemon = {
    enable = true;

    # configure nix
    settings = {
      # try freeing space upto 5gb when only 1gb is free
      min-free = 1 * 1024 * 1024 * 1024;
      max-free = 5 * 1024 * 1024 * 1024;

      # aggressive gc
      keep-outputs = false;
      keep-derivations = false;
      auto-optimise-store = true;

      # enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # enable cachix
      substituters = [
        "https://finix.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "finix.cachix.org-1:0ejikHDeCp0UErsduUUHcg9IJczY2/h2e5132Z/As/c="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # disable global registry
      flake-registry = "";

      # disable annoying git messages
      warn-dirty = false;

      # declutter home
      use-xdg-base-directories = true;
    };

  };

  # pin `nixpkgs#foo` to the locked input instead of the moving unstable ref
  environment.etc."nix/registry.json".text = builtins.toJSON {
    version = 2;
    flakes = [
      {
        from = {
          type = "indirect";
          id = "nixpkgs";
        };
        to = {
          type = "github";
          owner = "NixOS";
          repo = "nixpkgs";
          inherit (inputs.nixpkgs) rev narHash;
        };
      }
    ];
  };

  # enable nh and nh-clean
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 10 --keep-since 3d";
    };
  };
}
