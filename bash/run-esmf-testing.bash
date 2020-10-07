#!/usr/bin/env bash
set -Eeuxo pipefail

GCC_VERSION=10.2.0
OPENMPI_VERSION=4.0.5
BASELIBS_VERSION=6.0.16

cd ../Ubuntu20

bash build_full_stack.bash 2>&1 | tee build_full_stack.out

docker rm --force runner
docker run --name runner -dit gmao/ubuntu20-baselibs:${BASELIBS_VERSION}-openmpi_${OPENMPI_VERSION}-gcc_${GCC_VERSION}
docker exec -t runner bash "/opt/esmf-test-Dockerfile.baselibs.bash"
docker stop runner
