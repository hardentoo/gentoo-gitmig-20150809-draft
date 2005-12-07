# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pariguide/pariguide-0.43a.ebuild,v 1.4 2005/12/07 11:15:14 herbs Exp $

inherit multilib

IUSE=""

DESCRIPTION="PariGUIde, a GUI for the math. program Pari-GP"
HOMEPAGE="http://www.skalatan.de/pariguide/"
SRC_URI="mirror://sourceforge/pariguide/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86 ppc ~sparc alpha ~hppa"

DEPEND="<x11-libs/qt-4
	virtual/x11"

RDEPEND=">=sci-mathematics/pari-2.1.0"

src_compile() {
	econf \
		--with-qt-dir="/usr/qt/3" \
		--with-qt-libraries="/usr/qt/3/$(get_libdir)" \
		|| die "Error: econf failed!"
	emake || die "Error: emake failed!"
}

src_install() {
	make DESTDIR=${D} install || die

	#weiderly make install does not make the main binary executable
	chmod a+x ${D}/usr/bin/pariguide

	#make install does not honor docdir seting, have to move things manually
	dodoc AUTHORS COPYING README TODO
	mv ${D}/usr/doc/${PN}/html ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/doc/
}
