# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tpb/tpb-0.4.2.ebuild,v 1.1 2003/04/01 23:00:21 latexer Exp $

DESCRIPTION="Thinkpad button utility"
HOMEPAGE="http://savannah.nongnu.org/projects/tpb/"
SRC_URI="http://savannah.nongnu.org/download/tpb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/xosd"

src_compile() {
	econf

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
pkg_postinst() {
	einfo "tpb requires you to have nvram support compiled into"
	einfo "your kernel to function."
}
