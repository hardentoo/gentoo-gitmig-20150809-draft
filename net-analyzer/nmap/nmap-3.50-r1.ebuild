# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.50-r1.ebuild,v 1.6 2004/06/22 23:12:33 malc Exp $

inherit gcc eutils

DESCRIPTION="utility for network exploration or security auditing"
HOMEPAGE="http://www.insecure.org/nmap/"
SRC_URI="http://www.insecure.org/nmap/dist/${P}.tar.bz2
	http://www.packetstormsecurity.nl/UNIX/nmap/${PN}-3.20_statistics-1.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha arm hppa amd64"
IUSE="gtk gnome"

DEPEND="virtual/glibc
	dev-libs/libpcre
	gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/${PN}-3.20_statistics-1.diff
}

src_compile() {
	econf `use_with gtk nmapfe` || die
	emake -j1 || die
}

src_install() {
	einstall nmapdatadir=${D}/usr/share/nmap install || die
	use gnome || rm -rf ${D}/usr/share/gnome/

	dodoc CHANGELOG HACKING INSTALL docs/README docs/*.txt
	dohtml docs/*.html
}
