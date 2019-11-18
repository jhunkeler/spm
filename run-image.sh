#!/bin/bash
d="$(pwd)"
image=spm

docker build -t ${image} .
docker run \
    --rm -it \
    -v $d/../pkgs:/build/pkgs \
    -v $d/../sources:/build/sources \
    -v $d/scripts:/build/scripts \
    ${image}
