pkg_info() {
	_xDESC="Minimalistic client for Redis"

	_xFILE="hiredis-0.13.3.tar.gz"
	_xFILE_PATH=hiredis-0.13.3

	_xNAME=hiredis/0.13.3
}

pkg_build() {
	make PREFIX=${PREFIX} all && make PREFIX=${PREFIX} install
}
