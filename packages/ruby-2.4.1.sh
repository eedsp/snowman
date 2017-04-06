pkg_info() {
    _xDESC="Ruby: powerful, clean, object-oriented scripting language"

    _xFILE="ruby-2.4.1.tar.gz"
    _xFILE_PATH=ruby-2.4.1

    _xNAME=ruby/2.4.1
}

pkg_build() {

    func_pkgconfig "jemalloc" "openssl"

    jemalloc_CFLAGS=$(pkg-config --cflags jemalloc)
    jemalloc_LIBS=$(pkg-config --libs jemalloc)

    openssl_CFLAGS=$(pkg-config --cflags openssl)
    openssl_LIBS=$(pkg-config --libs openssl)

    if [ -e "/usr/local/opt/gmp" ]; then
        WITH_GMP="--with-gmp=/usr/local/opt/gmp"
    elif [ -e "${PKG_INSTALL_PATH}/gmp" ]; then
        WITH_GMP="--with-gmp=${PKG_INSTALL_PATH}/gmp"
    fi

    export CFLAGS="-I/usr/local/include ${jemalloc_CFLAGS} ${openssl_CFLAGS}"
    export LDFLAGS="-L/usr/local/lib ${jemalloc_LIBS} ${openssl_LIBS}"

    if [ ${vOS} = "Darwin" ]; then
        ./configure --prefix=${PREFIX} \
            --enable-shared --enable-pthread --with-jemalloc ${WITH_GMP}
    elif [ ${vOS} = "Linux" ]; then
        ./configure --prefix=${PREFIX} \
            --enable-shared --enable-pthread ${WITH_GMP}
    fi
     make -j 6 && make install
}
