pkg_info() {
	_xDESC="ICU"

	_xUNPACK_CMD="tar xvfj ${FILE} -C ${EXDIR}"
	_xFILE="icu4c-59_1-src.tgz"
	_xFILE_PATH=icu

	_xNAME=icu/59.1
}

pkg_build() {
	cd source && (
		configure --prefix=${PREFIX} --enable-strict --enable-shared && make -j 6 && make install
	)
}
