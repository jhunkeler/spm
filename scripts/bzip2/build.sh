#!/bin/bash
name=bzip2
version=1.0.8
revision=0
sources=(
    https://sourceware.org/pub/bzip2/${name}-${version}.tar.gz
)
depends=()


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    make -f Makefile-libbz2_so CC="gcc $CFLAGS $LDFLAGS"
    make bzip2 bzip2recover CC="gcc $CFLAGS $LDFLAGS"
}

function package() {
    mkdir -p "$destdir"
    install -dm755 "$destdir"/{bin,lib,include,share/man/man1}
    install -m755 bzip2-shared "$destdir"/bin/bzip2
    install -m755 bzip2recover bzdiff bzgrep bzmore "$destdir"/bin
    ln -sf bzip2 "$destdir"/bin/bunzip2
    ln -sf bzip2 "$destdir"/bin/bzcat
    cp -a libbz2.so* "$destdir"/lib
    ln -s libbz2.so.${version} "$destdir"/lib/libbz2.so
    ln -s libbz2.so.${version} "$destdir"/lib/libbz2.so.1
    install -m644 bzlib.h "$destdir"/include
    install -m644 bzip2.1 "$destdir"/share/man/man1
    ln -sf bzip2.1 "$destdir"/share/man/man1/bunzip2.1
    ln -sf bzip2.1 "$destdir"/share/man/man1/bzcat.1
    ln -sf bzip2.1 "$destdir"/share/man/man1/bzip2recover.1
}


