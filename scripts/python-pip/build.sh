#!/bin/bash
name=python-pip
version=19.2.3
revision=0
sources=(https://github.com/pypa/${name/python-/}/archive/${version}.tar.gz)
depends=(
    'git'
    'python-3'
    'python-setuptools'
)

function prepare() {
    tar xf ${version}.tar.gz
    cd ${name/python-/}-${version}
}

function package() {
    python setup.py install --root="${destdir}" --prefix="${prefix}"
    #find ${destdir} -type f | xargs sed -i -e "s|${build_runtime}|${prefix}|g"
}
