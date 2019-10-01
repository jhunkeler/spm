#!/bin/bash
name=zlib
version=1.2.11
revision=0
sources=(
    "http://zlib.net/${name}-${version}.tar.gz"
)
depends=()


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


