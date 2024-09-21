{
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = import ./keys.nix;

  services.nginx = {
    enable = true;
    virtualHosts."etna.typhon-ci.org" = {
      addSSL = true;
      enableACME = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "typhon@typhon-ci.org";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  system.stateVersion = "24.05";
}
