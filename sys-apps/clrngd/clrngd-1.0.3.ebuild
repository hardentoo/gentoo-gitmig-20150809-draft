# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/clrngd/clrngd-1.0.3.ebuild,v 1.7 2007/04/21 23:03:54 robbat2 Exp $

DESCRIPTION="Clock randomness gathering daemon"
HOMEPAGE="http://echelon.pl/pubs/"
SRC_URI="http://echelon.pl/pubs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/libc sys-devel/gcc"
RDEPEND="virtual/libc"

src_compile() {
	econf --bindir=/usr/sbin || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	newinitd ${FILESDIR}/clrngd-init.d clrngd
	newconfd ${FILESDIR}/clrngd-conf.d clrngd
}
