# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dar/dar-2.0.0.ebuild,v 1.1 2003/11/06 09:34:31 matsuu Exp $

DESCRIPTION="A full featured backup tool, aimed for disks (floppy,CDR(W),DVDR(W),zip,jazz etc.)"
HOMEPAGE="http://dar.linux.free.fr/"
SRC_URI="mirror://sourceforge/dar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-libs/zlib-1.1.3"

src_compile() {

	econf || die
	#emake || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README THANKS TODO
}
