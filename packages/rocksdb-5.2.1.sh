pkg_info() {
    _xDESC="Embeddable, persistent key-value store for fast storage"

    _xURL="https://github.com/facebook/rocksdb/archive/rocksdb-5.2.1.tar.gz"
    _xFILE="rocksdb-5.2.1.tar.gz"
    _xFILE_PATH=rocksdb-rocksdb-5.2.1

    _xNAME=rocksdb/5.2.1
}

pkg_build() {

    func_pkgconfig "jemalloc" "snappy" "gflags"

    jemalloc_CFLAGS=$(pkg-config --cflags jemalloc)
    jemalloc_LIBS=$(pkg-config --libs jemalloc)

    snappy_CFLAGS=$(pkg-config --cflags snappy)
    snappy_LIBS=$(pkg-config --libs snappy)

    gflags_CFLAGS=$(pkg-config --cflags gflags)
    gflags_LIBS=$(pkg-config --libs gflags)

    export CFLAGS="-I/usr/local/include ${jemalloc_CFLAGS} ${snappy_CFLAGS} ${gflags_CFLAGS}"
    export LDFLAGS="-L/usr/local/lib ${jemalloc_LIBS} ${snappy_LIBS} ${gflags_LIBS}"

    make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 -j 6 shared_lib
    make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 -j 6 static_lib
    make INSTALL_PATH=${PREFIX} PORTABLE=1 DEBUG_LEVEL=0 install
}
