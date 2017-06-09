pkg_info() {
	_xDESC="Berkeley DB - High performance key/value database"

	_xFILE="db-6.2.23.tar.gz"
	_xFILE_PATH="db-6.2.23"

	_xNAME=db/6.2.23
}

pkg_build() {
	cd build_unix && (
		../dist/configure --prefix=${PREFIX} \
			--enable-cxx --enable-sql \
		&& make -j 6 && make install
	)
}
