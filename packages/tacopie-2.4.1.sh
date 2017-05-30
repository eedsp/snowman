pkg_info() {
	_xDESC="C++ TCP Library"

	_xFILE="tacopie-2.4.1.tar.gz"
	_xFILE_PATH=tacopie-2.4.1

	_xNAME=tacopie/2.4.1
}

pkg_build() {

	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
		mkdir -p _build && cd _build && cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DCMAKE_BUILD_TYPE=Release \
		&& make -j 6 && make install
	)
}
