# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/commonbox-styles/commonbox-styles-0.3.ebuild,v 1.3 2002/10/22 15:45:00 bjb Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Common styles for flux|black|open(box)."
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://mkeadle.org/ebuilds/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND="virtual/x11"

src_install () {

	insinto /usr/share/commonbox/styles
	doins ${S}/styles/*
	dodoc README.commonbox-styles COPYING

}
