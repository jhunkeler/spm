#!/bin/bash
name=git
version=2.24.0
revision=0
sources=(
    "https://github.com/${name}/${name}/archive/v${version}.tar.gz"
)
build_depends=(
    "automake"
    "gettext"
    "libtool"
)
depends=(
    "curl"
    "zlib"
)


function prepare() {
    tar xf v${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    make configure
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


