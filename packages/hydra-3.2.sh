pkg_info() {
	_xDESC="process management system for starting parallel jobs"

	_xUNPACK_CMD="tar xvfz ${FILE} -C ${EXDIR}"
	_xFILE="hydra-3.2.tar.gz"
	_xFILE_PATH=hydra-3.2

	_xNAME=mpich/3.2

}

pkg_build() {
	./configure --prefix=${PREFIX} && make -j 6 && make install
}
