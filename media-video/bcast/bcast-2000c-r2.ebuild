# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/bcast/bcast-2000c-r2.ebuild,v 1.2 2002/07/11 06:30:42 drobbins Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Realtime audio and video editor"
SRC_URI="ftp://heroines.sourceforge.net/pub/heroines/${A}"
HOMEPAGE="http://heroines.sourceforge.net/"

DEPEND="virtual/glibc dev-lang/nasm
	>=sys-devel/gcc-2.95.2
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.2.1
	virtual/x11"

RDEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.2.1
	virtual/x11"

src_unpack() {
  unpack ${A}
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    try ./configure
    try make

}

src_install () {

    into /usr
    dobin bcast/bcast2000
    dolib.so bcbase/libbcbase.so
    dolib.so guicast/libguicast.so
    insopts -m 755
    insinto /usr/lib/bcast/plugins
    doins plugins/*.plugin
    dodoc COPYING
    docinto html
    dodoc docs/*.html docs/*.png docs/*.jpg

}



