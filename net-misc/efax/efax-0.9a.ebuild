# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/efax/efax-0.9a.ebuild,v 1.4 2004/07/15 02:45:56 agriffis Exp $

S=${WORKDIR}/${P}-001114
DESCRIPTION="A simple fax program for single-user systems"
SRC_URI="http://www.cce.com/efax/download/${P}-001114.tar.gz"
HOMEPAGE="http://www.cce.com/efax/"
KEYWORDS="x86 ~ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

src_unpack () {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:CFLAGS=:CFLAGS=${CFLAGS}:" Makefile.orig > Makefile
}

src_compile () {
	emake
}

src_install () {
	dobin efax efix fax
	doman efax.1 efix.1 fax.1
	dodoc COPYING README
}
