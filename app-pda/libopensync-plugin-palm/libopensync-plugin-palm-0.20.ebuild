# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-palm/libopensync-plugin-palm-0.20.ebuild,v 1.2 2007/02/12 21:04:08 peper Exp $

inherit autotools

DESCRIPTION="OpenSync Palm Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	>=app-pda/pilot-link-0.11.8
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patch fixing includedir for pisock
	epatch "${FILESDIR}/${PN}-include_pisock.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
