#!/bin/bash
name=libffi
version=3.2.1
revision=0
sources=(
    ftp://sourceware.org/pub/libffi/${name}-${version}.tar.gz
)
build_depends=(
    "automake"
    "autoconf"
    "libtool"
)
depends=(
    "base"
)


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure \
        --prefix=$prefix \
        --libdir=$prefix/lib \
        --enable-pax_emutramp
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
    mv "${destdir}/${prefix}/lib64"/* "${destdir}/${prefix}/lib"
    rm -rf "${destdir}/${prefix}/lib64"
}
