# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pbbuttonsd/pbbuttonsd-0.5.2.ebuild,v 1.4 2003/02/28 13:18:14 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PBButtons is a program to map special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="~ppc ~x86 -mips"
DEPEND="virtual/glibc"
RDEPEND=""
SLOT=0
LICENSE="GPL-2"

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc || die "sorry, pbbuttons configure failed"
	make || die "sorry, failed to compile pbbuttons"
}

src_install() {

	dodir /etc/power
	make sysconfdir=${D}/etc DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbbuttonsd.rc5 pbbuttonsd
	dodoc README COPYING

}
