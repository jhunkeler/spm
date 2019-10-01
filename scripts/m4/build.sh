#!/bin/bash
name=m4
version=1.4.18
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.xz"
)
depends=(
)

function prepare() {
    tar xf ${name}-${version}.tar.xz
    cd ${name}-${version}
    patch -p1 -i ${build_script_root}/"m4-1.4.18-glibc-change-work-around.patch"
}

function build() {
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
