# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.53.ebuild,v 1.6 2002/10/04 06:02:37 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Excellent program which automatically configures your PPP session"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"
HOMEPAGE="http://open.nit.ca/"

DEPEND="net-libs/wvstreams"
RDEPEND="net-dialup/ppp"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	
	cp Makefile Makefile.orig
	sed -e "s:PREFIX=/usr/local:PREFIX=/usr:" \
		Makefile.orig > Makefile
}

src_install() {
	cp Makefile Makefile.orig
	sed -e "s:PPPDIR=/etc/ppp/peers:PPPDIR=${D}/etc/ppp/peers:" \
		Makefile.orig > Makefile

	make \
		PREFIX=${D}/usr \
		install || die

	dodoc ANNOUNCE CHANGES COPYING.LIB README 
	dodoc debian/copyright debian/changelog
}
