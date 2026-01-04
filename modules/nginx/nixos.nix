{ config, tailnet }:
{
  security.acme = {
    acceptTerms = true;
    defaults.email = "acme@gabx.io";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."${config.networking.hostName}.${tailnet}.ts.net" = {
      sslCertificate = "/var/lib/tailscale/certs/hercules.tail428a67.ts.net.crt";
      sslCertificateKey = "/var/lib/tailscale/certs/hercules.tail428a67.ts.net.key";
      addSSL = true;
      enableACME = true;
      serverName = "${config.networking.hostName}.${tailnet}.ts.net";
      locations."/assistant" = {
        proxyPass = "http://127.0.0.1:${config.services.home-assistant.config.http.server_port}";
        proxyWebsockets = true;
      };
      locations."/stremio" = {
        proxyPass = "http://127.0.0.1:11470";
        proxyWebsockets = true;
      };
      locations."/plex" = {
        proxyPass = "http://127.0.0.1:32400";
        proxyWebsockets = true;
      };
    };
  };
}
