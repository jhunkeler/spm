#!/bin/bash
name=python
version=3.7.5
_basever=${version%.*}
revision=0
sources=(
    "https://www.python.org/ftp/python/${version}/Python-${version}.tar.xz"
)
build_depends=(
    "sed-4.7"
    "grep-3.3"
    "automake"
    "autoconf"
    "xz"
)
depends=(
    "bzip2-1.0"
    "e2fsprogs"
    "gdbm"
    "gzip"
    "libexpat"
    "libffi-3.2"
    "ncurses-6"
    "openssl-1.1.1d"
    "tar-1.32"
    "readline-8"
    "sqlite-3.29"
    "tk-8.6"
    "zlib-1.2"
)


function prepare() {
    tar xf Python-${version}.tar.xz
    cd Python-${version}
}

function build() {
    #zlib="zlib zlibmodule.c ${CFLAGS} ${LDFLAGS} -lz"
    #echo "${zlib/=/ }" >> Modules/Setup

    export CFLAGS="${CFLAGS} -I${build_runtime}/include/ncursesw"
    ./configure \
        --prefix="${prefix}" \
        --enable-ipv6 \
        --enable-loadable-sqlite-extensions \
        --enable-shared \
        --with-computed-gotos \
        --with-dbmliborder=gdbm:ndbm \
        --with-pymalloc \
        --with-system-expat \
        --without-ensurepip
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
    echo "Removing __pycache__ directories..."
    find "${destdir}" -name "__pycache__" | xargs rm -rf

    ln -s python3             "${destdir}/${prefix}"/bin/python
    ln -s python3-config      "${destdir}/${prefix}"/bin/python-config
    ln -s idle3               "${destdir}/${prefix}"/bin/idle
    ln -s pydoc3              "${destdir}/${prefix}"/bin/pydoc
    ln -s python${_basever}.1 "${destdir}/${prefix}"/share/man/man1/python.1
    chmod 755 "${destdir}/${prefix}"/lib/libpython${_basever}m.so
}


