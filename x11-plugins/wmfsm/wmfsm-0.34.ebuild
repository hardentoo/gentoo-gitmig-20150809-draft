# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfsm/wmfsm-0.34.ebuild,v 1.9 2004/07/17 11:03:34 s4t4n Exp $

IUSE=""
DESCRIPTION="dockapp for monitoring filesystem usage"
HOMEPAGE="http://www.cs.ubc.ca/~cmg/"
SRC_URI="http://www.cs.ubc.ca/~cmg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc"

DEPEND="virtual/x11"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install() {

	einstall || die "make install failed"

}
