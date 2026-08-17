# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hercules/hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
  };

  time.timeZone = "America/Sao_Paulo";

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@gabx.io";
  };

  users.users = {
    root = {
      openssh.authorizedKeys.keyFiles = [
        ./hercules/authorized_keys
      ];
    };
    aripiprazole = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keyFiles = [
        ./hercules/authorized_keys
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    helix
  ];

  services = {
    adguardhome = {
      enable = true;
      openFirewall = true;
      mutableSettings = false;
      host = "0.0.0.0";
      port = 3003;
      settings = {
        dns = {
          bind_hosts = [ "192.168.1.128" ];
          upstream_dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
          bootstrap_dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        };

        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
          parental_enabled = false;
        };
      };
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        ChallengeResponseAuthentication = "no";
        PubkeyAuthentication = "yes";
      };
    };

    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };

    plex = {
      enable = true;
    };

    tailscale = {
      enable = true;
      useRoutingFeatures = "server";
    };

    home-assistant = {
      enable = true;
      extraComponents = [
        # Components required to complete the onboarding
        "analytics"
        "google_translate"
        "met"
        "radio_browser"
        "shopping_list"
        # Recommended for fast zlib compression
        # https://www.home-assistant.io/integrations/isal
        "isal"
      ];
      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = { };
      };
    };

    # nginx = {
    #   enable = true;
    #   recommendedProxySettings = true;
    #   recommendedTlsSettings = true;
    #   virtualHosts."${config.networking.hostName}.${tailnet}.ts.net" = {
    #     sslCertificate = "/var/lib/tailscale/certs/hercules.tail428a67.ts.net.crt";
    #     sslCertificateKey = "/var/lib/tailscale/certs/hercules.tail428a67.ts.net.key";
    #     addSSL = true;
    #     enableACME = true;
    #     serverName = "${config.networking.hostName}.${tailnet}.ts.net";
    #     locations."/assistant" = {
    #       proxyPass = "http://127.0.0.1:${config.services.home-assistant.config.http.server_port}";
    #       proxyWebsockets = true;
    #     };
    #     locations."/stremio" = {
    #       proxyPass = "http://127.0.0.1:11470";
    #       proxyWebsockets = true;
    #     };
    #     locations."/plex" = {
    #       proxyPass = "http://127.0.0.1:32400";
    #       proxyWebsockets = true;
    #     };
    #   };
    # };
  };

  networking = {
    hostName = "Hercules"; # Define your hostname.
    networkmanager.enable = true;
    firewall = {
      trustedInterfaces = [ "tailscale0" ];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      stremio = {
        image = "stremio/server:v4.20.14";
        ports = [
          "127.0.0.1:11470:11470"
        ];
        volumes = [
          "stremio-data:/storage/stremio"
        ];
      };
      homeassistant = {
        volumes = [ "home-assistant:/config" ];
        environment.TZ = "America/Sao_Paulo";
        # Note: The image will not be updated on rebuilds, unless the version label changes
        image = "ghcr.io/home-assistant/home-assistant:stable";
        extraOptions = [
          # Use the host network namespace for all sockets
          "--network=host"
          # Pass devices into the container, so Home Assistant can discover and make use of them
          "--device=/dev/ttyACM0:/dev/ttyACM0"
        ];
      };
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
