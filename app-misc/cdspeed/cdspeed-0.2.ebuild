# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdspeed/cdspeed-0.2.ebuild,v 1.2 2003/01/07 03:17:57 agenkin Exp $

DESCRIPTION="Change the speed of your CD drive."
HOMEPAGE="http://linuxfocus.org/~guido/"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
KEYWORDS="x86"

SLOT="0"
SRC_URI="http://linuxfocus.org/~guido/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:^CFLAGS=-O.*:CFLAGS=${CFLAGS}:" \
		Makefile.orig > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe cdspeed
	exeinto /usr/lib/cdspeed
	doexe cdmount
	dodoc README
}
