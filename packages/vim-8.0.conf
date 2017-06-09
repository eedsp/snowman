pkg_info() {
	_xDESC="Vim - the ubiquitous text editor"

	_xFILE="vim-8.0.tar.gz"
	_xFILE_PATH=vim-8.0

	_xNAME=vim/8.0
}

pkg_build() {
	./configure --prefix=${PREFIX} \
		--enable-multibyte --enable-hangulinput \
		--with-python3 --with-perl --with-ruby \
	&& make -j 6 && make install \
	&& (
		cd ${PREFIX}/bin && if [ ! -e "vi" ]; then
			ln -s vim vi
		fi
	)
}
