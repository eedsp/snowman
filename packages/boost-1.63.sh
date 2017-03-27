pkg_info() {
	_xDESC="Boost"

	_xFILE="boost_1_63_0.tar.gz"
	_xFILE_PATH="boost_1_63_0"

	_xNAME=boost/1.63.0
}

pkg_build() {
	log_msg "[INFO] $(pwd)"

	#MPI_PATH=${PKG_INSTALL_PREFIX}/mpich/3.2
	#ICU_PATH=${PKG_INSTALL_PREFIX}/icu/58.2

	MPI_PATH=${PKG_INSTALL_PATH}/mpich
	ICU_PATH=${PKG_INSTALL_PATH}/icu

	# CFLAGS="-I/usr/local/include -I${ICU_PATH}/include"
	# LDFLAGS="-L/usr/local/lib -L${ICU_PATH}/lib"

	bootstrap.sh --prefix=${PREFIX} \
		--libdir=${PREFIX}/lib \
		--with-icu=${ICU_PATH} \
		--without-libraries=python
	echo "using mpi : ${MPI_PATH}/bin/mpic++ ;" > user-config.jam

	b2 --prefix=${PREFIX} \
		--libdir=${PREFIX}/lib \
		--user-config=user-config.jam \
		-d2 -j4 --show-librarie threading=multi \
	&& b2 install --prefix=${PREFIX} \
		--libdir=${PREFIX}/lib \
		--user-config=user-config.jam \
		-d2 -j4 --show-librarie threading=multi
}
