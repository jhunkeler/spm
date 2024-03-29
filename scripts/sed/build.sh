#!/bin/bash
name=sed
version=4.7
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.xz"
)
build_depends=(
    "xz"
)
depends=(
    "grep"
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
