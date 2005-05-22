# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashalot/hashalot-0.3.ebuild,v 1.13 2005/05/22 02:06:48 vapier Exp $

DESCRIPTION="CryptoAPI utils"
HOMEPAGE="http://www.kerneli.org/"
SRC_URI="http://www.paranoiacs.org/~sluskyb/hacks/hashalot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

src_test() {
	make check-TESTS || die
}

src_install() {
	make DESTDIR="${D}" install || die "install error"
}
