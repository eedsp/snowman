pkg_info() {
	_xDESC="Apache Portable Runtime Utility"

	_xFILE="apr-util-1.5.4.tar.gz"
	_xFILE_PATH="apr-util-1.5.4"

	_xNAME=apr-util/1.5.4
}

pkg_build() {
	#--with-apr=${PKG_INSTALL_PREFIX}/apr/1.5.2 \
	./configure --prefix=${PREFIX} \
		--with-apr=${PKG_INSTALL_PATH}/apr \
	&& make -j 6 && make install

#	--with-berkeley-db=${PKG_INSTALL_PREFIX}/db/6.2.23 \
#	--with-openssl=${PKG_INSTALL_PREFIX}/openssl/1.0.2k \
#	--with-sqlite3=${PKG_INSTALL_PREFIX}/sqlite/3.13.0 \

}


