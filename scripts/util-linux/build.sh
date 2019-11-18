#!/bin/bash
name=util-linux
version=2.34
revision=0
sources=(
    "https://mirrors.edge.kernel.org/pub/linux/utils/${name}/v${version}/${name}-${version}.tar.gz"
)
depends=(
    "autoconf"
    "automake"
    "libtool"
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


