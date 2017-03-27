pkg_info() {
	_xDESC="Git - fast, scalable, distributed revision control system"

	_xFILE="git-2.12.1.tar.gz"
	_xFILE_PATH=git-2.12.1

	_xNAME=git/2.12.1
}

pkg_build() {
	if [ ${vOS} = "Darwin" ]; then
		make configure
		./configure --prefix=${PREFIX} \
			--with-curl --with-openssl=${PKG_INSTALL_PREFIX}/openssl/1.0.2k \
			--with-perl=${APP_PATH}/bin/perl \
			--with-python=${APP_PATH}/bin/python
		make -j 6 && make install
	elif [ ${vOS} = "Linux" ]; then
		make configure
		./configure --prefix=${PREFIX} \
			--with-curl=${APP_PATH} --with-openssl=${APP_PATH} \
			--with-perl=${APP_PATH}/bin/perl \
			--with-python=${APP_PATH}/bin/python
		make -j 6 && make install
	fi
}
