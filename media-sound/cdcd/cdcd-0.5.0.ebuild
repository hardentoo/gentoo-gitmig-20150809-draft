# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.5.0.ebuild,v 1.7 2002/07/11 06:30:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a simple yet powerful command line cd player"
SRC_URI="http://cdcd.undergrid.net/source_archive/${P}.tar.gz"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.0
	>=sys-libs/readline-4.0
	>=media-libs/libcdaudio-0.99.4"

src_compile() {

	econf || die
	make || die
}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
