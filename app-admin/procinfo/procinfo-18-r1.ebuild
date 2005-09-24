# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/procinfo/procinfo-18-r1.ebuild,v 1.5 2005/09/24 15:42:22 carlo Exp $

inherit eutils

DESCRIPTION="A utility to prettyprint /proc/*"
SRC_URI="http://www.kozmix.org/src/${P}.tar.gz"
HOMEPAGE="http://www.kozmix.org/src/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/kernel-2.6.patch
	epatch ${FILESDIR}/cpu-usage-fix.patch
}

src_compile() {
	# -ltermcap is default and isn't available in gentoo
	# but -lncurses works just as good
	emake LDLIBS=-lncurses || die
}

src_install() {
	dobin procinfo
	newbin lsdev.pl lsdev
	newbin socklist.pl socklist

	doman *.8
	dodoc README CHANGES
}
