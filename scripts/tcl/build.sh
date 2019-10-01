#!/bin/bash
name=tcl
version=8.6.9
revision=0
sources=(
    "https://prdownloads.sourceforge.net/${name}/${name}${version}-src.tar.gz"
)
depends=(
    "bzip2-1.0.8-0.tar.gz"
    "grep-3.3-0.tar.gz"
    "sed-4.7-0.tar.gz"
    "pcre-8.43-0.tar.gz"
    "zlib-1.2.11-0.tar.gz"
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
