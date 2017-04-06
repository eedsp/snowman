pkg_info() {
	_xDESC="The C++ REST SDK is a Microsoft project for cloud-based client-server communication"

	_xFILE="cpprestsdk-2.9.1.tar.gz"
	_xFILE_PATH=cpprestsdk-2.9.1

	_xNAME=cpprestsdk/2.9.1
}

pkg_build() {

	log_msg "[INFO] ${vOS}"

	for vPATH_prefix in "/usr/local/opt" "${PKG_INSTALL_PATH}"
	do
		if [ -z ${BOOST_ROOT} ] && [ -e "${vPATH_prefix}/boost" ]; then
			BOOST_ROOT=${vPATH_prefix}/boost
            break;
		fi
    done

    func_pkgconfig "openssl"

    openssl_CFLAGS=$(pkg-config --cflags openssl)
    openssl_LIBS=$(pkg-config --libs openssl)

	export CFLAGS="-I/usr/local/include ${openssl_CFLAGS}"
	export LDFLAGS="-L/usr/local/lib ${openssl_LIBS}"

	# for cmake
	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
        if [ -n "${BOOST_ROOT}" ]; then
            OPT_BOOST_ROOT="-DBOOST_ROOT=${BOOST_ROOT}"
        fi
		mkdir -p _build && cd _build && cmake ../Release -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			${OPT_BOOST_ROOT} -DBUILD_SAMPLES=OFF -DBUILD_TESTS=OFF \
			-DCMAKE_BUILD_TYPE=Release 
		make -j 6 && make install
	)
}
