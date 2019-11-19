#!/bin/bash
name=ncurses
version=6.1
revision=0
sources=(
    "http://mirror.rit.edu/gnu/${name}/${name}-${version}.tar.gz"
)
build_depends=(
    "automake"
    "autoconf"
)
depends=(
    "base"
)


function prepare() {
    tar xf ${name}-${version}.tar.gz
    cd ${name}-${version}
}

function build() {
    ./configure --prefix=$prefix \
        --without-static \
        --with-shared \
        --with-normal \
        --without-debug \
        --without-ada \
        --enable-widec \
        --enable-pc-files \
        --with-cxx-bindings \
        --with-cxx-shared \
        --with-manpage-format=normal \
        --with-pkg-config-libdir="${prefix}/lib/pkgconfig"
    make -j${maxjobs}
}

function package() {
    make install DESTDIR="${destdir}"

    # Arch linux maintainers have the right idea here...

    # fool packages looking to link to non-wide-character ncurses libraries
    for lib in ncurses ncurses++ form panel menu; do
      echo "INPUT(-l${lib}w)" > "${destdir}/${prefix}/lib/lib${lib}.so"
      ln -s ${lib}w.pc "${destdir}/${prefix}/lib/pkgconfig/${lib}.pc"
    done

    for lib in tic tinfo; do
      echo "INPUT(libncursesw.so.${version:0:1})" > "${destdir}/${prefix}/lib/lib${lib}.so"
      ln -s libncursesw.so.${version:0:1} "${destdir}/${prefix}/lib/lib${lib}.so.${version:0:1}"
      ln -s ncursesw.pc "${destdir}${prefix}/lib/pkgconfig/${lib}.pc"
    done

    # some packages look for -lcurses during build
    echo 'INPUT(-lncursesw)' > "${destdir}${prefix}/lib/libcursesw.so"
    ln -s libncurses.so "${destdir}/${prefix}/lib/libcurses.so"

    # some packages include from ncurses/
    ln -s ncursesw "${destdir}/${prefix}/include/ncurses"

}
