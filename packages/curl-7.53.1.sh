pkg_info() {
    _xDESC="Get a file from an HTTP, HTTPS or FTP server"

    _xFILE="curl-7.53.1.tar.gz"
    _xFILE_PATH="curl-7.53.1"

    _xNAME=curl/7.53.1
}

pkg_build() {

    func_pkgconfig "libidn"

    libidn_CFLAGS=$(pkg-config --cflags libidn)
    libidn_LIBS=$(pkg-config --libs libidn)

    export CFLAGS="-I/usr/local/include ${libidn_CFLAGS}"
    export LDFLAGS="-L/usr/local/lib ${libidn_LIBS}"

    if [ ${_OS_NAME} = "Darwin" ]; then
        ./configure --prefix=${PREFIX} \
            --with-libidn --with-darwinssl 
    elif [ ${_OS_NAME} = "Linux" ]; then
        ./configure --prefix=${PREFIX} \
            --with-libidn=${APP_PATH} --with-ssl=${APP_PATH} 
    fi
    make -j 6 && make install
}
