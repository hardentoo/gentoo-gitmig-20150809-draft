# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ibmonitor/ibmonitor-1.2.ebuild,v 1.2 2004/06/30 23:47:19 eldad Exp $

DESCRIPTION="Interactive bandiwidth monitor"
HOMEPAGE="http://ibmonitor.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"
RESTRICT="nomirror"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

S=${WORKDIR}/${PN}

DEPEND="dev-perl/TermReadKey"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /usr/bin
	dobin ibmonitor

	dodoc AUTHORS ChangeLog INSTALL README TODO
}
