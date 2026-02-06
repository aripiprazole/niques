# niques

Nix-Darwin and NixOS configurations for my machines, managed with [Nix flakes](https://wiki.nixos.org/wiki/Flakes) and [just](https://github.com/casey/just).

## Hosts

| Host | Platform | Description |
|------|----------|-------------|
| **Tadpole** | aarch64-darwin | Enterprise machine (config in [private flake](https://github.com/aripiprazole/niques.tadpole)) |
| **Condor** | aarch64-darwin | Development machine |
| **Hercules** | x86_64-linux | Home server |

## Structure

```
.
├── flake.nix          # Flake entrypoint
├── hosts/
│   ├── darwin.nix     # Shared macOS base config
│   ├── Condor/        # Condor host config
│   └── Hercules/      # Hercules host config
├── modules/           # Shared home-manager modules (git, zsh, helix, zed, ...)
└── justfile           # Build commands
```

## Setup

Requires [Determinate Nix](https://docs.determinate.systems/determinate-nix/).

```sh
# Rebuild the current host
just rebuild

# Garbage collect and optimise the store
just gc
```
