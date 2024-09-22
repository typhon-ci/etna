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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = import ./keys.nix;

  services.typhon = {
    enable = true;
    hashedPasswordFile = "${./hash.txt}";
  };

  services.nginx = {
    enable = true;
    virtualHosts."etna.typhon-ci.org" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        recommendedProxySettings = true;
        proxyPass = "http://localhost:3000";
      };
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
