{
  description = "My NixOS config :DD";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, ... }@inputs:
      let
        system = "x86_64-linux";
        mkHost = { hostName, secureBoot }:
          let pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
          };
          in nixpkgs.lib.nixosSystem {
            inherit system;

            specialArgs = { inherit hostName secureBoot inputs pkgs-unstable; };

            modules = [
              ./hosts/${hostName}/configuration.nix
              lanzaboote.nixosModules.lanzaboote
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit hostName inputs pkgs-unstable; };
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
          pc = mkHost {
            hostName = "pc";
            secureBoot = true;
          };
        };
      };
}
