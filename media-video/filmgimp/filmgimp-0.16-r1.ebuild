# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/filmgimp/filmgimp-0.16-r1.ebuild,v 1.1 2003/03/20 14:22:06 vladimir Exp $

DESCRIPTION="motion picture editing tool used for painting and retouching of movies"
SRC_URI="mirror://sourceforge/filmgimp/${P}.tar.gz"
HOMEPAGE="http://filmgimp.org/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="png zlib"

DEPEND="=x11-libs/gtk+-1*
	png? ( >=media-libs/libpng-1.2 )
	zlib? ( sys-libs/zlib )
	media-libs/tiff
	media-libs/jpeg"

src_compile(){
	econf \
		--with-gnu-ld \
		|| die "configure failed"

	emake || die
}

src_install(){
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING* README* NEWS
}
