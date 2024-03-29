#!/bin/bash
name=sqlite
version=3.29.0
_v=3290000
revision=0
sources=(
    "https://sqlite.org/2019/${name}-autoconf-${_v}.tar.gz"
)
build_depends=(
    "automake"
    "autoconf"
    "readline"
    "zlib"
)
depends=(
    "readline"
    "zlib"
)


function prepare() {
    tar xf ${name}-autoconf-${_v}.tar.gz
    cd ${name}-autoconf-${_v}
}

function build() {
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
