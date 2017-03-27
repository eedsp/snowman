pkg_info() {
	_xDESC="perl: Highly capable, feature-rich programming language"

	_xFILE="perl-5.24.1.tar.gz"
	_xFILE_PATH=perl-5.24.1

	_xNAME=perl/5.24.1
}

pkg_build() {
	./Configure -Dprefix=${PREFIX} \
		-des \
		-Duse64bital \
		-Duseshrplib \
		-Duselargefiles \
		-Dusethreads
	make -j 6 && make install
}
