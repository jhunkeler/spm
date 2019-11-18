#!/bin/bash
name=git
version=2.24.0
revision=0
sources=(
    "https://github.com/${name}/${name}/archive/v${version}.tar.gz"
)
build_depends=(
    "autoconf"
    "automake"
    "curl"
    "gettext"
    "libtool"
    "openssl"
    "pcre"
    "tk"
    "zlib"
)
depends=(
    "curl"
    "openssl"
    "pcre"
    "tk"
    "zlib"
)


function prepare() {
    tar xf v${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    export LDFLAGS="${LDFLAGS} -Wl,-rpath=${prefix}/lib"
    make configure
    ./configure --prefix=$prefix \
        --libdir=$prefix/lib \
        --with-curl \
        --with-expat \
        --with-tcltk
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


