# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lsdvd/lsdvd-0.16-r1.ebuild,v 1.8 2008/12/22 15:50:04 armin76 Exp $

inherit autotools eutils

DESCRIPTION="Utility for getting info out of DVDs"
HOMEPAGE="http://untrepid.com/lsdvd/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/libdvdread"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-types.patch \
		"${FILESDIR}"/${P}-usec.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README
}
