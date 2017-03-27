
PKG_LIST=(
	"apr-1.5.2"
	"apr-util-1.5.4"
	"expat-2.2.0"

	"gmp-6.1.2"
	"xz-5.2.3"

	"icu-58.2"
	"pcre-8.40"
	"pcre2-10.23"

	"libsodium-1.0.12"
	"zeromq-4.2.2"
	"czmq-4.0.2"

	"sqlite-3.17.0"

	"hiredis-0.13.3"

	"jansson-2.10"
	"rapidjson-1.1.0"

	"libev-4.24"
	"libuv-1.11.0"

	"ck-0.6.0"
	"mpich-3.2"

	"perl-5.24.1"
	"python-3.6.1"

	"lua-5.3.4.sh"	
	"ruby-2.4.1"
)

for vPKG in ${PKG_LIST[@]}
do
	echo "[CMD] ${PKGM}/script/pkg.build.sh ${vPKG}"
	${PKGM}/script/pkg.build.sh ${vPKG}
done
