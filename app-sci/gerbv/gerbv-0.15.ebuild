# Copyright 1999-2003 Gentoo Technologies, Inc. and Tim Yamin <plasmaroo@gentoo.org> <plasmaroo@squirrelsoft.org.uk>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gerbv/gerbv-0.15.ebuild,v 1.1 2003/11/27 22:54:08 plasmaroo Exp $

S=${WORKDIR}/${P}

DESCRIPTION="gerbv - The gEDA Gerber Viewer"
SRC_URI="http://www.geda.seul.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.geda.seul.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha sparc"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-1.2.10
	x11-base/xfree"

src_compile() {

	econf || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS CONTRIBUTORS COPYING ChangeLog NEWS README

}
