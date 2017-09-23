# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils git-r3

DESCRIPTION="OpenStreetMap data to PostgreSQL converter."
HOMEPAGE="https://github.com/openstreetmap/osm2pgsql"
EGIT_REPO_URI="https://github.com/openstreetmap/osm2pgsql.git"

LICENSE="GPL-2"
SLOT="0/9999"
KEYWORDS=""

IUSE="internal-libosmium lua test"

RDEPEND="
    sys-libs/zlib
    dev-libs/expat
    app-arch/bzip2
    sci-libs/geos
    sci-libs/proj
    dev-libs/boost:=[threads]
    dev-db/postgresql
    !internal-libosmium? ( sci-geosciences/libosmium[protozero,utfcpp] )
    lua? ( dev-lang/lua )
    test? ( dev-lang/python )
"
DEPEND="${RDEPEND}"

src_configure() {
    local mycmakeargs=(
        -DEXTERNAL_LIBOSMIUM=$(usex !internal-libosmium)

        -DWITH_LUA=$(usex lua)
        -DBUILD_TESTS=$(usex test)
    )
    cmake-utils_src_configure
}
