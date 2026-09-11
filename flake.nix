# flake.nix
{
  description = "oceanicc's petrichor but nix-ified";

  inputs = {
    # pin to current stable release
    nixpkgs.url = "nixpkgs/nixos-26.05";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    affinity-nix.url = "github:mrshmllow/affinity-nix";

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
