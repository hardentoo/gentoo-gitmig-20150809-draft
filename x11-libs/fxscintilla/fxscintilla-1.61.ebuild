# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fxscintilla/fxscintilla-1.61.ebuild,v 1.2 2004/07/09 13:30:35 fmccor Exp $

DESCRIPTION="A free source code editing component for the FOX-Toolkit"
HOMEPAGE="http://www.nongnu.org/fxscintilla"
SRC_URI="http://savannah.nongnu.org/download/fxscintilla/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=x11-libs/fox-1.2.6"

src_compile () {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README INSTALL
}
