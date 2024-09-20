{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.typhon.url = "github:typhon-ci/typhon";
  outputs =
    {
      self,
      nixpkgs,
      typhon,
    }:
    { };
}
