#!/bin/bash
name=python
version=3.7.4
_basever=${version%.*}
revision=0
sources=(
    "https://www.python.org/ftp/python/${version}/Python-${version}.tar.xz"
)
depends=(
    "tar-1.32-0.tar.gz"
    "openssl-1.1.1d-0.tar.gz"
    "libffi-3.2.1-0.tar.gz"
    "grep-3.3-0.tar.gz"
    "sed-4.7-0.tar.gz"
    "sqlite-3.29.0-0.tar.gz"
    "zlib-1.2.11-0.tar.gz"
    "tcl-8.6.9-0.tar.gz"
    "tk-8.6.9-0.tar.gz"
)


function prepare() {
    tar xf Python-${version}.tar.xz
    cd Python-${version}
}

function build() {

    zlib="zlib zlibmodule.c ${CFLAGS} ${LDFLAGS} -lz"
    echo "${zlib/=/ } >> Modules/Setup"

    ./configure \
        --prefix="${prefix}" \
        --enable-ipv6 \
        --enable-loadable-sqlite-extensions \
        --enable-shared \
        --with-computed-gotos \
        --with-lto \
        --with-dbmliborder=gdbm:ndbm \
        --with-pymalloc \
        --with-system-expat \
        --with-system-ffi \
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


