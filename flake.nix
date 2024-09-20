{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.typhon.url = "github:typhon-ci/typhon";

  outputs =
    {
      self,
      nixpkgs,
      disko,
      typhon,
    }:
    {
      nixosConfigurations.etna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          typhon.nixosModules.default
          ./configuration.nix
        ];
      };
    };
}
