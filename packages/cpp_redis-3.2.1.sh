pkg_info() {
	_xDESC="Apache Runtime Library"

	_xFILE="cpp_redis-3.2.1.tar.gz"
	_xFILE_PATH=cpp_redis-3.2.1

	_xNAME=cpp_redis/3.2.1
}

pkg_build() {

	git submodule init
	git submodule update
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
