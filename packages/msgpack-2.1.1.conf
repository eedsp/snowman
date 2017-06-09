pkg_info() {
	_xDESC="MessagePack implementation for C and C++ / msgpack.org[C/C++]"

	_xFILE="msgpack-2.1.1.tar.gz"
	_xFILE_PATH=msgpack-2.1.1

	_xNAME=msgpack/2.1.1
}

pkg_build() {
	if [ -e "./_build" ]; then
		log_msg "[CMD] $(pwd) - rm -rf ./_build"
		rm -rf ./_build
	fi
	(
		mkdir -p ./_build && cd ./_build && cmake .. -DCMAKE_INSTALL_PREFIX=${PREFIX} \
			-DCMAKE_BUILD_TYPE=Release \
		&& make -j 6 && make install
	)
}
