#!/bin/bash
name=hstcal
version=2.3.1
revision=0
sources=()
build_depends=(
    "git"
    "python-3"
)
depends=(
    "cfitsio"
)


function prepare() {
    git clone https://github.com/spacetelescope/${name}
    cd ${name}
    git checkout ${version}
    curl -L https://waf.io/waf-2.0.18 >../waf
    chmod +x ../waf
}

function build() {
    ../waf configure --prefix=$prefix
}

function package() {
    ../waf install --destdir="${destdir}"
}


