# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/m17n-lib/m17n-lib-1.5.2.ebuild,v 1.6 2009/05/27 20:17:12 jer Exp $

inherit flag-o-matic

DESCRIPTION="Multilingual Library for Unix/Linux"
HOMEPAGE="http://www.m17n.org/m17n-lib/"
SRC_URI="http://www.m17n.org/m17n-lib-download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
#IUSE="anthy gd ispell"
IUSE="gd"

RDEPEND="x11-libs/libXaw
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXrender
	x11-libs/libXft
	dev-libs/libxml2
	dev-libs/fribidi
	>=media-libs/freetype-2.1
	media-libs/fontconfig
	gd? ( media-libs/gd )
	>=dev-libs/libotf-0.9.4
	>=dev-db/m17n-db-${PV}"
# linguas_th? ( || ( app-i18n/libthai app-i18n/wordcut ) )
# anthy? ( app-i18n/anthy )
# ispell? ( app-text/ispell )

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use gd && ! built_with_use media-libs/gd png ; then
		eerror "m17n-lib requires GD to be built with png support. Please add"
		eerror "'png' to your USE flags, and re-emerge media-libs/gd."
		die "Missing USE flag."
	fi
}

src_compile() {
	append-flags -fPIC
	econf $(use_with gd) || die
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
