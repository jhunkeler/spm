#!/bin/bash
name=reloc
version=1.0.0
revision=0
sources=(
    "https://github.com/jhunkeler/${name}/archive/${version}.tar.gz"
)
build_depends=(
    "cmake"
)
depends=()

function prepare() {
    tar xf ${version}.tar.gz
    cd ${name}-${version}
    mkdir -p build
    cd build
}

function build() {
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${prefix}"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
