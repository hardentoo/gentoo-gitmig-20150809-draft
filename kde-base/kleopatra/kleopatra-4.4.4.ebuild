# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kleopatra/kleopatra-4.4.4.ebuild,v 1.2 2010/06/21 15:53:48 scarabeus Exp $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Kleopatra - KDE X.509 key manager"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	app-crypt/gpgme
	>=dev-libs/libassuan-2.0.0
	dev-libs/libgpg-error
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkleo)
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
"

KMEXTRACTONLY="
	libkleo
"
KMLOADLIBS="libkleo"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.3-assuan2.patch"
)

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kwatchgnupg
		"
	fi

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs=(
		-DWITH_QGPGME=ON
	)

	kde4-meta_src_configure
}
