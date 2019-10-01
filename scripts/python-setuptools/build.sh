#!/bin/bash
name=python-setuptools
version=41.2.0
revision=0
sources=(https://github.com/pypa/setuptools/archive/v${version}.tar.gz)
depends=('python-3')

function prepare() {
    tar xf v${version}.tar.gz
    cd ${name/python-/}-${version}
}

function package() {
    python bootstrap.py
    python setup.py install --root="${destdir}" --prefix="${prefix}"
    #find ${destdir} -type f | xargs -I'{}' sed -i -e "s|${build_runtime}|${prefix}|g" '{}'
}
