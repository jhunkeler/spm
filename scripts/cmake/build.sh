#!/bin/bash
name=cmake
version=3.15.5
revision=0
sources=(
    "https://github.com/Kitware/CMake/releases/download/v${version}/${name}-${version}.tar.gz"
)
depends=()


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./bootstrap --prefix="${prefix}"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


