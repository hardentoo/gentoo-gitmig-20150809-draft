# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.0.8.ebuild,v 1.1 2002/02/17 17:41:09 azarah Exp $


S=${WORKDIR}/${P}
DESCRIPTION="A high-quality and portable font engine"
SRC_URI="http://prdownloads.sourceforge.net/freetype/${P}.tar.bz2"
HOMEPAGE="http://www.freetype.org/"

SLOT="2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# Enable hinting for truetype fonts
	cd ${S}/include/freetype/config
	cp ftoption.h ftoption.h.orig
	sed -e 's:#undef TT_CONFIG_OPTION_BYTECODE_INTERPRETER:#define TT_CONFIG_OPTION_BYTECODE_INTERPRETER:' \
		ftoption.h.orig > ftoption.h
	cd ${S}
}

src_compile() {
	make CFG="--host=${CHOST} --prefix=/usr" || die
	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc ChangeLog README 
	dodoc docs/{BUILD,CHANGES,*.txt,PATENTS,readme.vms,todo}
}
