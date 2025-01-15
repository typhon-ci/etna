{
  sources ? import ./npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs { inherit system; },
}:
pkgs.nixos [
  (sources.disko + "/module.nix")
  ./configuration.nix
]
