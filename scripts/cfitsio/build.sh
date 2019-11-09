#!/bin/bash
name=cfitsio
version=3.47
revision=0
sources=(
    "http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/${name}-${version}.tar.gz"
)
depends=("curl")


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


