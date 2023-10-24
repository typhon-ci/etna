{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    package = pkgs.nixVersions.nix_2_18;
    settings.experimental-features = ["nix-command" "flakes"];
    settings.trusted-users = ["@wheel"];
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  services.typhon = {
    enable = true;
    hashedPassword = "dff8e62c85e0c51717518d5d7d2a34abfa332e582a9cf73fb4dc9be080840047";
    domain = "etna.typhon-ci.org";
    webroot = "";
    https = true;
  };

  services.nginx.virtualHosts."etna.typhon-ci.org" = {
    forceSSL = true;
    enableACME = true;
  };

  networking.hostName = "etna";
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_IE.UTF-8";

  security.sudo.wheelNeedsPassword = false;
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "pnm@pnm.tf";

  users.users.pnm = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINta9hgVN7WHEbVWeXeUFimDY4EP7WgkW6psxS1U4IHk"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.firewall.allowedTCPPorts = [80 443];

  system.stateVersion = "23.11";
}
