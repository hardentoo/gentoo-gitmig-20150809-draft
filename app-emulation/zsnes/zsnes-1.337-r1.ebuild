# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/zsnes/zsnes-1.337-r1.ebuild,v 1.2 2002/05/08 08:48:20 spider Exp $
# Don't attempt to introduce $CFLAGS usage, docs say result will be slower.

S=${WORKDIR}/${P}
DESCRIPTION="zsnes is an excellent snes (super nintendo) emulator"
SRC_URI="ftp://prdownloads.sourceforge.net/zsnes/zsnes1337src.tar.gz"
HOMEPAGE="http://www.zsnes.com/"

RDEPEND="opengl? ( virtual/opengl )
    virtual/x11
    >=media-libs/libsdl-1.2.0
    sys-libs/zlib
    media-libs/libpng"

DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"
	

src_compile() {
    cd ${S}/src
    use opengl || myconf="--without-opengl"
    ./configure --prefix=/usr --host=${CHOST} $myconf || die
    make || die
}
src_install () {
    cd ${S}/src
    into /usr
    dobin zsnes
    doman linux/zsnes.man
    cd ${S}
    dodoc *.txt linux/*
}
