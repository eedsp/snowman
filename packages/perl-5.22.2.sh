pkg_info() {
	_xDESC="perl: Highly capable, feature-rich programming language"

	_xFILE="perl-5.22.1.tar.gz"
	_xFILE_PATH=perl-5.22.1

	_xNAME=perl/5.22.2
}

pkg_build() {
	./configure -Dprefix=${PREFIX} \
		-des \
		-Duse64bital \
		-Duseshrplib \
		-Duselargefiles \
		-Dusethreads
	make -j 6 && make install
}
