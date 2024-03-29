#!/bin/bash
name=libtool
version=2.4.6
revision=0
sources=(
    "http://ftp.gnu.org/gnu/${name}/${name}-${version}.tar.gz"
)
depends=()


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix="${prefix}"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
