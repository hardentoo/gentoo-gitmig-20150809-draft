# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/cherokee/cherokee-0.4.1.ebuild,v 1.2 2003/07/13 21:44:10 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="ftp://laurel.datsi.fi.upm.es/pub/linux/cherokee/${P}.tar.gz"
HOMEPAGE="http://www.alobbs.com/cherokee"
LICENSE="GPL-2"
DEPEND="sys-libs/glibc"
RDEPEND="${DEPEND}"
KEYWORDS="x86"
SLOT="0"

src_compile() {
	econf
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
