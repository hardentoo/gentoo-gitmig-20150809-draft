# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-libs/compface/compface-1.4.ebuild,v 1.12 2003/03/05 15:34:42 agriffis Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Utilities and library to convert to/from X-Face format"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-errno.diff
}

src_install () {
	dodir /usr/share/man/man{1,3} /usr/{bin,include,lib}
	make \
		prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc README ChangeLog
}
