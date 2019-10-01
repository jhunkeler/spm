#!/bin/bash
name=curl
version=7.66.0
revision=0
sources=(
    "https://curl.haxx.se/download/${name}-${version}.tar.xz"
)
depends=(
    "libffi-3.2.1-0.tar.gz"
    "openssl-1.1.1d-0.tar.gz"
)


function prepare() {
    tar xf ${name}-${version}.tar.xz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
