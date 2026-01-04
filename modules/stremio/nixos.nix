{
  virtualisation.oci-containers.containers = {
    stremio = {
      image = "stremio/server:v4.20.14";
      ports = [
        "127.0.0.1:11470:11470"
      ];
      volumes = [
        "stremio-data:/storage/stremio"
      ];
    };
  };
}
