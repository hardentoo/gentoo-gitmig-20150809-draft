# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgaccess/pgaccess-0.99.0.20040219.ebuild,v 1.1 2004/09/23 19:32:44 nakano Exp $

inherit eutils

MY_P=${P//./_}

DESCRIPTION="a database frontend for postgresql"
HOMEPAGE="http://www.pgaccess.org/"
SRC_URI="mirror://sourceforge/pgaccess/${MY_P}.tgz"
LICENSE="POSTGRESQL"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND="virtual/libc"

RDEPEND=">=dev-lang/tcl-8.3.4
	>=dev-lang/tk-8.3.4
	>=dev-db/postgresql-7.3
	dev-tcltk/tcllib"


src_compile() {
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_install() {
	make prefix=${D} install || die
	rm -rf ${D}/usr/lib/pgaccess/win32 \
		${D}/usr/lib/pgaccess/Makefile
	rm -rf ${D}/usr/lib/pgaccess/osx
	dodir /usr/share/doc/${PF}
	mv ${D}/usr/lib/pgaccess/{README,changelog,copyright,demo,doc/html,todo} ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/lib/pgaccess/doc
}

pkg_postinst() {
	einfo "When running the program, if you encount the error "
	einfo "\"Error: Shared library file: '/usr/lib/libpgtcl.so' does not exist.\","
	einfo "you need to emerge postgresql with USE='tcltk' again"
}
