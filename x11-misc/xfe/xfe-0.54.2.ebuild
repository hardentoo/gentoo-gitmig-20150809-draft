# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-0.54.2.ebuild,v 1.4 2003/11/11 13:14:45 vapier Exp $

DESCRIPTION="MS-Explorer like file manager for X"
HOMEPAGE="http://sourceforge.net/projects/xfe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="x11-libs/fox"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS FAQ README TODO NEWS
}
