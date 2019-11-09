#!/bin/bash
name=tcl
version=8.6.9
revision=0
sources=(
    "https://prdownloads.sourceforge.net/${name}/${name}${version}-src.tar.gz"
)
build_depends=(
    "automake"
    "autoconf"
)
depends=(
    "pcre-8.43-0.tar.gz"
)

function prepare() {
    tar xf ${name}${version}-src.tar.gz
    cd ${name}${version}
}

function build() {
    cd unix
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
    chmod 755 "${destdir}/${prefix}"/lib/*.so
}
