{
  description = "My NixOS config :DD";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs:
      let
        system = "x86_64-linux";
        mkHost = { hostName, secureBoot }: nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit hostName secureBoot; };

          modules = [
            ./hosts/${hostName}/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit hostName; };
              home-manager.users.staszek = import ./modules/home.nix;
            }
          ];
        };

      in
      {
        nixosConfigurations = {
          laptop = mkHost {
            hostName = "laptop";
            secureBoot = true;
          };
        };
      };
}
