# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tc2/tc2-0.5.4.ebuild,v 1.1 2003/10/30 02:38:02 seemant Exp $

IUSE="static debug"

S=${WORKDIR}/${P}
DESCRIPTION="TC2 is a library to simplify writing of modular programs."
HOMEPAGE="http://tc2.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="OpenSoftware"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ~amd64"


DEPEND=">=dev-libs/libtc-0.6.0"


src_compile() {

	local myconf
	myconf="--with-gnu-ld"

	use debug && myconf="${myconf} --enable-debug"

	use static && myconf="${myconf} --enable-static"

	econf ${myconf} || die "configure failed"

	make || die

}

src_install() {
	make DESTDIR=${D} install || die
}
