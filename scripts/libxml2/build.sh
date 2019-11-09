#!/bin/bash
name=libxml2
version=2.9.9
revision=0
sources=(
    "https://github.com/GNOME/${name}/archive/v${version}.tar.gz"
)
build_depends=(
    "automake"
    "autoconf"
)
depends=()

function prepare() {
    tar xf v${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./autogen.sh --prefix="${prefix}"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
