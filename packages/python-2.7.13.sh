pkg_info() {
	_xDESC="Interpreted, interactive, object-oriented programming language"

	_xFILE="Python-2.7.13.tgz"
	_xFILE_PATH=Python-2.7.13

	_xNAME=python/2.7.13
    _xOPT_NAME=python2
}

pkg_build() {

    func_pkgconfig "openssl" "libffi"

    openssl_CFLAGS=$(pkg-config --cflags openssl)
    openssl_LIBS=$(pkg-config --libs openssl)

    libffi_CFLAGS=$(pkg-config --cflags libffi)
    libffi_LIBS=$(pkg-config --libs libffi)

	export CFLAGS="-I/usr/local/include ${openssl_CFLAGS} ${libffi_CFLAGS}"
	export LDFLAGS="-L/usr/local/lib ${openssl_LIBS} ${libffi_LIBS}"

	if [ ${vOS} = "Darwin" ]; then
		MACOSX_DEPLOYMENT_TARGET=10.12
	fi
	./configure --prefix=${PREFIX} \
		--enable-ipv6 \
		--enable-shared \
        --without-gcc \
		--without-ensurepip \
	&& make -j 6 && make install 
}
