#!/bin/bash
name=ncurses
version=6.1
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.gz"
)
depends=()


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix \
        --with-shared \
        --with-normal \
        --without-debug \
        --without-ada \
        --enable-widec \
        --enable-pc-files \
        --with-cxx-bindings \
        --with-cxx-shared \
        --with-manpage-format=normal
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
