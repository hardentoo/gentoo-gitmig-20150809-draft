# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlinc/htmlinc-1.0_beta1-r1.ebuild,v 1.2 2005/10/15 14:18:21 grobian Exp $

inherit eutils

DESCRIPTION="HTML Include System by Ulli Meybohm"
HOMEPAGE="http://www.meybohm.de/"
SRC_URI="http://meybohm.de/files/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc-macos ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"
S=${WORKDIR}/htmlinc

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/htmlinc-gcc3-gentoo.patch
}

src_compile() {
	emake CFLAGS="${CXXFLAGS} -Wall" || die
}

src_install() {
	dobin htmlinc
	dodoc README
}
