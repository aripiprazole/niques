# niques

Nix-Darwin and NixOS configurations for my machines, managed with [Nix flakes](https://wiki.nixos.org/wiki/Flakes) and [just](https://github.com/casey/just).

## Hosts

| Host         | Platform       | Description                                                                                    |
| ------------ | -------------- | ---------------------------------------------------------------------------------------------- |
| **Condor**   | aarch64-darwin | Development machine                                                                            |
| **Hercules** | x86_64-linux   | Home server                                                                                    |


## Setup

Requires [Determinate Nix](https://docs.determinate.systems/determinate-nix/).

```sh
# Rebuild the current host
just rebuild

# Garbage collect and optimise the store
just gc
```
