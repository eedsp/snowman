pkg_info() {
	_xDESC="Get a file from an HTTP, HTTPS or FTP server"

	_xFILE="curl-7.53.1.tar.gz"
	_xFILE_PATH="curl-7.53.1"

	_xNAME=curl/7.53.1
}

pkg_build() {
	vOS=`uname -s`
	if [ ${vOS} = "Darwin" ]; then
			./configure --prefix=${PREFIX} \
				--with-libidn=${PKG_INSTALL_PREFIX}/libidn/1.33 --with-darwinssl \
			&& make -j 6 && make install
	elif [ ${vOS} = "Linux" ]; then
			./configure --prefix=${PREFIX} \
				--with-libidn=${APP_PATH} --with-ssl=${APP_PATH} \
			&& make -j 6 && make install
	fi
}
