# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libspt/libspt-1.1-r1.ebuild,v 1.1 2009/04/03 15:35:05 patrick Exp $

EAPI="2"

DESCRIPTION="Library for handling root privilege"
HOMEPAGE="http://www.j10n.org/libspt/index.html"
SRC_URI="http://www.j10n.org/libspt/${P}.tar.bz2"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

inherit eutils

src_prepare() {
	epatch "${FILESDIR}/libspt-werror.patch"
}

src_install() {

	make DESTDIR="${D}" mandir=/usr/share/man install || die
	dodoc CHANGES
}
