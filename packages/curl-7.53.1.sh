pkg_info() {
	_xDESC="Get a file from an HTTP, HTTPS or FTP server"

	_xFILE="curl-7.53.1.tar.gz"
	_xFILE_PATH="curl-7.53.1"

	_xNAME=curl/7.53.1
}

pkg_build() {

	for tPKG_NAME in libidn
	do
		for PKGCONFIG_prefix in "/usr/local/opt" "${PKG_INSTALL_PATH}"
		do
			tmpPATH="${PKGCONFIG_prefix}/${tPKG_NAME}/lib/pkgconfig"
			if [ -e "${PKGCONFIG_prefix}" ]; then
				PKG_CONFIG_PATH=${tmpPATH}:${PKG_CONFIG_PATH}
				break
			fi
		done
	done

    libidn_CFLAGS=$(pkg-config --cflags libidn)
    libidn_LIBS=$(pkg-config --libs libidn)

	CFLAGS="-I/usr/local/include ${libidn_CFLAGS}"
	LDFLAGS="-L/usr/local/lib ${libidn_LIBS}"

	vOS=`uname -s`
	if [ ${vOS} = "Darwin" ]; then
		./configure --prefix=${PREFIX} \
			--with-libidn --with-darwinssl 
	elif [ ${vOS} = "Linux" ]; then
		./configure --prefix=${PREFIX} \
			--with-libidn=${APP_PATH} --with-ssl=${APP_PATH} 
	fi
	make -j 6 && make install
}
