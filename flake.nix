{
  inputs = {
    typhon.url = "github:typhon-ci/typhon";
    nixpkgs.follows = "typhon/nixpkgs";
    flake-compat.follows = "typhon/flake-compat";
  };

  outputs = {
    typhon,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.etna = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        typhon.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
