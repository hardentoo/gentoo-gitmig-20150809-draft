# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnu-netcat/gnu-netcat-0.7.1.ebuild,v 1.13 2006/08/16 00:50:26 squinky86 Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="the GNU network swiss army knife"
HOMEPAGE="http://netcat.sourceforge.net/"
SRC_URI="mirror://sourceforge/netcat/netcat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ~ppc ppc-macos sparc x86"
IUSE="nls debug"

DEPEND="virtual/libc"

S=${WORKDIR}/netcat-${PV}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable debug` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	rm ${D}/usr/bin/nc
	dodoc AUTHORS ChangeLog NEWS README TODO
}
