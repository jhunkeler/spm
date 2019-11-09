#!/bin/bash
name=patchelf
version=0.10
revision=0
sources=("https://github.com/NixOS/${name}/archive/${version}.tar.gz")
build_depends=(
    "automake"
    "autoconf"
)
depends=()

function prepare() {
    tar xf ${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./bootstrap.sh
    ./configure --prefix="${prefix}"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


