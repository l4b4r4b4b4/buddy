# buddy

## Requirements
1. devenv
2. make

## Training
Training is done with a cross-platform development environment build with devenv (nix) powered by [Genisis](https://genesis-world.readthedocs.io/en/latest/)

TLDR
```bash
make training
```

0. Initliase Python devenv. RUN ONLY ONCE!!
```bash
cd training && devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs
```
1. Install devenv
First part is optional, and only really needed after changing development environment with `training/devenv.nix`
```bash
devenv update && devenv shell
```
