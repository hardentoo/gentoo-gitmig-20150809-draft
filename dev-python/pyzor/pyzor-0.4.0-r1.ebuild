# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzor/pyzor-0.4.0-r1.ebuild,v 1.4 2004/05/04 12:32:13 kloeri Exp $

inherit distutils

DESCRIPTION="Pyzor is a distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://pyzor.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyzor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/python
	sys-libs/gdbm"

src_install () {
	mydoc="INSTALL NEWS PKG-INFO THANKS UPGRADING"
	distutils_src_install
	dohtml docs/usage.html
	rm -rf ${D}/usr/share/doc/pyzor
	fperms 755 /usr/bin/pyzor*
	dodir /usr/sbin
	mv ${D}/usr/bin/pyzord ${D}/usr/sbin/
}

pkg_postinst() {
	ewarn "/usr/bin/pyzord has been moved to /usr/sbin"
}
