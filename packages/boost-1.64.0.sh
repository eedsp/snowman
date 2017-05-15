pkg_info() {
	_xDESC="Boost"

	_xFILE="boost_1_64_0.tar.gz"
	_xFILE_PATH="boost_1_64_0"

	_xNAME=boost/1.64.0
}

pkg_build() {
	log_msg "[INFO] $(pwd)"

	#MPI_PATH=${PKG_INSTALL_PREFIX}/mpich/3.2
	#ICU_PATH=${PKG_INSTALL_PREFIX}/icu/58.2

	if [ -e "/usr/local/opt/mpich" ]; then
		MPI_PATH=/usr/local/opt/mpich
	elif [ -e "${PKG_INSTALL_PATH}/mpich" ]; then
		MPI_PATH=${PKG_INSTALL_PATH}/mpich
	fi
	if [ -e "/usr/local/opt/icu" ]; then
		ICU_PATH=/usr/local/opt/icu
	elif [ -e "${PKG_INSTALL_PATH}/icu" ]; then
		ICU_PATH=${PKG_INSTALL_PATH}/icu
	fi

	if [ ${_OS_NAME} = "Darwin" ]; then
		CXXFLAGS="-stdlib=libc++ -std=c++11"
		LDFLAGS="-stdlib=libc++"
	elif [ ${_OS_NAME} = "Linux" ]; then
		CXXFLAGS="-std=c++11"
	fi
	bootstrap.sh --prefix=${PREFIX} \
		--libdir=${PREFIX}/lib \
		--with-icu=${ICU_PATH} \
		--without-libraries=python
	echo "using mpi : ${MPI_PATH}/bin/mpic++ ;" > user-config.jam

	b2 --prefix=${PREFIX} \
		--libdir=${PREFIX}/lib \
		--user-config=user-config.jam \
		-d2 -j4 --show-librarie variant=release threading=multi \
	&& b2 install --prefix=${PREFIX} \
		--libdir=${PREFIX}/lib \
		--user-config=user-config.jam \
		-d2 -j4 --show-librarie variant=release threading=multi
}
