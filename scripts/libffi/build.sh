#!/bin/bash
name=libffi
version=3.2.1
revision=0
sources=(
    ftp://sourceware.org/pub/libffi/${name}-${version}.tar.gz
)
depends=()


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix --enable-pax_emutramp
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
