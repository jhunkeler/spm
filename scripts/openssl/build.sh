#!/bin/bash
name=openssl
version=1.1.1d
revision=0
sources=(
    "https://www.openssl.org/source/${name}-${version}.tar.gz"
)
depends=(
    "zlib-1.2.11-0.tar.gz"
)


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    export KERNEL_BITS=64
    export TARGET=linux-x86_64
    #mkdir -p ${build_runtime}/lib
    ./Configure \
        --prefix="$prefix" \
        --openssldir="$prefix/etc/ssl" \
        shared \
        threads \
        zlib-dynamic \
        no-ssl3-method \
        ${TARGET}

    #mkdir -p ${prefix}/{bin,lib,share}
    make -j${maxjobs}
}

function package() {
    make \
        DESTDIR="${destdir}" \
        MANDIR=${prefix}/share/man \
        MANSUFFIX=ssl \
        install
}
