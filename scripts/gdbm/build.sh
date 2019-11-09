#!/bin/bash
name=gdbm
version=1.18.1
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.gz"
)
build_depends=(
    "automake"
    "autoconf"
)
depends=(
    "readline"
)


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix --enable-libgdbm-compat
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
