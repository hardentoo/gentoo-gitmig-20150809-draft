# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20070323.ebuild,v 1.1 2007/04/06 14:57:42 dragonheart Exp $

inherit eutils

DESCRIPTION="Multicast file transfer tool"
HOMEPAGE="http://udpcast.linux.lu/"
SRC_URI="http://udpcast.linux.lu/download/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/libc
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-makefix.patch
}

src_install() {
	emake install DESTDIR=${D} || die "make install failed"
	dodoc *.txt
}
