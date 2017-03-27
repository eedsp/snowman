pkg_info() {
	_xDESC="JSON parser/generator for C++ with SAX and DOM style APIs"

	_xFILE="rapidjson-1.1.0.tar.gz"
	_xFILE_PATH=rapidjson-1.1.0

	_xNAME=rapidjson/1.1.0
}

pkg_build() {

	log_msg "[INFO] ${vOS}"

	# for cmake
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
