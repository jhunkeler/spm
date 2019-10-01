#!/bin/bash
name=tk
version=8.6.9
version_full="${version}.1"
revision=0
sources=(
    "https://prdownloads.sourceforge.net/tcl/${name}${version_full}-src.tar.gz"
)
depends=(
    "grep-3.3-0.tar.gz"
    "sed-4.7-0.tar.gz"
    "zlib-1.2.11-0.tar.gz"
    "tcl-${version}-0.tar.gz"
)

function prepare() {
    tar xf ${name}${version_full}-src.tar.gz
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
