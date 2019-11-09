#!/bin/bash
name=tk
version=8.6.9
version_full="${version}.1"
revision=0
sources=(
    "https://prdownloads.sourceforge.net/tcl/${name}${version_full}-src.tar.gz"
)
build_depends=(
    "tar"
    "automake"
)
depends=(
    "tcl-${version}"
)

function prepare() {
    tar xf ${name}${version_full}-src.tar.gz
    cd ${name}${version}
}

function build() {
    cd unix
    ./configure --prefix=$prefix --with-tcl=${build_runtime}/lib
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
    chmod 755 "${destdir}/${prefix}"/lib/*.so
}
