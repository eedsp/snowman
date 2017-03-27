pkg_info() {
	_xDESC="htop - an interactive process viewer for Unix"

	_xUNPACK_CMD="tar xvfz ${FILE} -C ${EXDIR}"
	_xFILE="htop-2.0.2.tar.gz"
	_xFILE_PATH=htop-2.0.2

	_xNAME=htop/2.0.2
}

pkg_build() {
	./configure --prefix=${PREFIX} --enable-unicode && make -j 6 && make install
}
