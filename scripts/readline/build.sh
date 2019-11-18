#!/bin/bash
name=readline
version=8.0
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.gz"
)
build_depends=(
    "automake"
    "autoconf"
    "ncurses"
)
depends=(
    "ncurses"
)


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix
    make -j${maxjobs} SHLIB_LIBS=-lncurses
}

function package() {
    make install DESTDIR="${destdir}"
}
