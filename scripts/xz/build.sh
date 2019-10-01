#!/bin/bash
name=xz
version=5.2.4
revision=0
sources=(
    "https://tukaani.org/xz/${name}-${version}.tar.gz"
)
depends=(
    "sed-4.7-0.tar.gz"
    "grep-3.3-0.tar.gz"
)


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


