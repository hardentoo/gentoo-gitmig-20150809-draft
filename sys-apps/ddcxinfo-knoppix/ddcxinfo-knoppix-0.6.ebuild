# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ddcxinfo-knoppix/ddcxinfo-knoppix-0.6.ebuild,v 1.5 2005/03/05 16:58:46 kingtaco Exp $

IUSE=""

DESCRIPTION="Program to automatically probe a monitor for information"
HOMEPAGE="http://www.knopper.net"

MY_PV=${PV}-5
SRC_URI="http://developer.linuxtag.net/knoppix/sources/${PN}_${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -amd64"

RDEPEND=""
DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	exeinto /usr/sbin
	doexe ddcxinfo-knoppix
	dodoc debian/changelog debian/control debian/copyright README COPYING
	doman debian/ddcxinfo-knoppix.1
}
