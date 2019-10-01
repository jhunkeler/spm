#!/bin/bash
name=grep
version=3.3
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.xz"
)
depends=()


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
