# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.62b.ebuild,v 1.8 2004/06/14 08:49:14 kloeri Exp $

DESCRIPTION="pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/tetex"

src_compile() {

	if has_version 'app-text/ptex' ; then
		cp muttprint muttprint.in
		sed -e "s/latex/platex/g" muttprint.in > muttprint
	fi
}

src_install() {
	# understanding the install part of the Makefiles.
	make prefix=${D}/usr docdir=${D}/usr/share/doc/ install || die
}
