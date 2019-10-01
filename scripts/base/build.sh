#!/bin/bash
name=base
version=1.0.0
revision=0
sources=()
depends=(
    # development tools
    "autoconf"
    "automake"
    "m4"
    # file manipulation
    "diffutils"
    "findutils"
    "grep"
    "sed"
    # archivers
    "tar"
    # compression
    "bzip2"
    "gzip"
    "xz"
    "zlib"
    # terminal
    "ncurses"
    "readline"
    # web
    "curl"
)

function prepare() {
    :
}

function build() {
    :
}

function package() {
    dest="${destdir}/${prefix}"
    schema=(
        bin
        etc
        lib
        libexec
        sbin
        tmp
        var/cache
        var/db
        var/empty
        var/games
        var/local
        var/log
        var/lock
        var/lib
        var/opt
        var/run
        var/tmp
    )
    mkdir -p "${dest}"
    pushd "${dest}"
        for d in "${schema[@]}"; do
            mkdir -p "${d}"
            chmod 0755 "${d}"
        done
        ln -sf lib lib64
    popd

}
