# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/dchub-0.2.5.ebuild,v 1.3 2003/03/11 13:10:18 vapier Exp $

HOMEPAGE="http://www.ac2i.tzo.com/dctc/#dchub"
DESCRIPTION="dchub (Direct Connect Hub), a linux hub for the p2p 'direct connect'"
SRC_URI="http://ac2i.tzo.com/dctc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/glibc
	=dev-libs/glib-1*
	sys-devel/perl
	dev-db/edb"

src_install() {
	einstall || die "install problem"

	dodoc Documentation/*
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

	dodir /etc/{conf,init}.d /etc/dchub
	exeinto /etc/init.d
	newexe ${FILESDIR}/dchub.init.d dchub
	insinto /etc/conf.d
	newins ${FILESDIR}/dchub.conf.d dchub
}
