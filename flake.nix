# flake.nix
{
  description = "oceanicc's petrichor but nix-ified";

  inputs = {
    # pin to current stable release
    nixpkgs.url = "nixpkgs/nixos-26.05";

    # only for certain packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # secure boot with systemd-boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    # remove boilerplate
    let
      mkHost = { hostname, system ? "x86_64-linux", extraModules ? [] }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            # default modules
            ./modules/common
            ./hosts/${hostname}
            inputs.lanzaboote.nixosModules.lanzaboote
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        # laptop
        nixey = mkHost {
          hostname = "nixey";
          extraModules = [
            ./modules/desktop
          ];
        };

        # homelab
        misato = mkHost {
          hostname = "misato";
          extraModules = [
            ./modules/homelab
          ];
        };

      };
    };

}
