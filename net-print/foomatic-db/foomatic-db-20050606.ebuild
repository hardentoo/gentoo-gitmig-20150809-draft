# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-20050606.ebuild,v 1.4 2005/08/02 14:57:01 gustavoz Exp $

DESCRIPTION="Foomatic printer database"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://www.linuxprinting.org/download/foomatic/${P}.tar.gz
	ppds? ( http://www.linuxprinting.org/download/foomatic/foomatic-filters-ppds-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE="cups ppds"

DEPEND="dev-libs/libxml2
	net-misc/wget
	net-misc/curl
	net-print/foomatic-filters
	net-print/foomatic-db-engine"

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf || die
	rm db/source/driver/stp.xml

	if use ppds ; then
		cd ../foomatic-filters-ppds-${PV}
		rm -f `find . -name "*gimp-print*" `
		rm -f `find . -name "*hpijs*" `
	fi
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	chmod -R 644 ${D}/usr/share/foomatic/db/
	chmod 755 ${D}/usr/share/foomatic/db/
	chmod 755 ${D}/usr/share/foomatic/db/source
	chmod 755 ${D}/usr/share/foomatic/db/source/{driver,opt,printer}

	if use ppds ; then
		cd ../foomatic-filters-ppds-${PV}
		./install -d ${D} -p /usr -z
		if use cups ; then
			dodir /usr/share/cups/model
			dosym /usr/share/ppd /usr/share/cups/model/foomatic-ppds
		fi
	fi
}
