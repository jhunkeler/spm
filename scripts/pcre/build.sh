#!/bin/bash
name=pcre
version=8.43
revision=0
sources=(
    "https://ftp.pcre.org/pub/${name}/${name}-${version}.tar.gz"
)
depends=(
    "bzip2"
    "readline"
    "zlib"
)

function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure \
        --prefix=${prefix} \
        --enable-unicode-properties \
        --enable-pcre16 \
        --enable-pcre32 \
        --enable-jit \
        --enable-pcregrep-libz \
        --enable-pcregrep-libbz2 \
        --enable-pcretest-readline
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}
