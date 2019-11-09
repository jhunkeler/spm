#!/bin/bash
name=libexpat
version=2.2.9
revision=0
sources=(
    "https://github.com/${name}/${name}/archive/R_${version//./_}.tar.gz"
)
build_depends=(
    "automake"
    "libtool"
)
depends=()


function prepare() {
    tar xf R_${version//./_}.tar.gz
    cd ${name}-R_${version//./_}/expat
}

function build() {
    ./buildconf.sh
    ./configure --prefix="${prefix}" \
        --libdir="${prefix}/lib"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"
}


