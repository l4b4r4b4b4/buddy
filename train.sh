#!/bin/sh
#!/bin/bash
cd training && \
devenv inputs add nixpkgs-python github:cachix/nixpkgs-python --follows nixpkgs && \
devenv update && devenv shell
