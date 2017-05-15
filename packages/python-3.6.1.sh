pkg_info() {
    _xDESC="Interpreted, interactive, object-oriented programming language"

    _xFILE="Python-3.6.1.tgz"
    _xFILE_PATH=Python-3.6.1

    _xNAME=python/3.6.1
    _xOPT_NAME=python3
}

pkg_build() {

    func_pkgconfig "openssl" "libffi"

    openssl_CFLAGS=$(pkg-config --cflags openssl)
    openssl_LIBS=$(pkg-config --libs openssl)

    libffi_CFLAGS=$(pkg-config --cflags libffi)
    libffi_LIBS=$(pkg-config --libs libffi)

    export CFLAGS="-I/usr/local/include ${openssl_CFLAGS} ${libffi_CFLAGS}"
    export LDFLAGS="-L/usr/local/lib ${openssl_LIBS} ${libffi_LIBS}"

    if [ ${_OS_NAME} = "Darwin" ]; then
        MACOSX_DEPLOYMENT_TARGET=10.12
    fi
    ./configure --prefix=${PREFIX} \
        --enable-ipv6 \
        --enable-shared \
        --with-threads \
        --without-gcc \
        --without-ensurepip \
        --enable-optimizations \
    && make -j 6 && make install \
    && (
        cd ${PREFIX}/bin && if [ ! -e "python" ] && [ -e "python3.6" ; then
            ln -s python3.6 python
        fi
    )
}
