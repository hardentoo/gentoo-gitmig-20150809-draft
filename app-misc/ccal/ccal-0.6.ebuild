# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ccal/ccal-0.6.ebuild,v 1.4 2005/05/09 00:44:41 wormo Exp $

DESCRIPTION="Curses-based calendar/journal/diary/todo utility"
HOMEPAGE="http://www.jamiehillman.co.uk/ccal/"
SRC_URI="mirror://gentoo/${P}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/python"

S=${WORKDIR}

src_install() {
	newbin ${P}.py ${PN} || die "dobin failed"
	dohtml ${FILESDIR}/instructions.htm || die "dohtml failed"
}

pkg_postinst() {
	echo
	einfo "Read /usr/share/doc/${PF}/html/instructions.htm for"
	einfo "information on using ccal."
	echo
}
