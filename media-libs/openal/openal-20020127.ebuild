# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/openal/openal-20020127.ebuild,v 1.2 2002/04/13 12:18:55 blocke Exp $

LIBVER="0.0.6"

S=${WORKDIR}/tmp/openal
DESCRIPTION="OpenAL, the Open Audio Library, is an open, vendor-neutral, cross-platform API for interactive, primarily spatialized audio"
SRC_URI="http://ftp.au.freebsd.org/pub/lokigames/openal/${P}.tar.gz"
HOMEPAGE="http://www.openal.org"
SLOT="0"

# documentation doesn't say which versions are required...

DEPEND="dev-lang/nasm
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	sdl? ( media-libs/libsdl )
	oggvorbis? ( media-libs/libvorbis )
	smpeg? ( media-libs/smpeg )"
	


src_compile() {

	local myconf

	use alsa && myconf="--enable-alsa " 
	use arts && myconf="--enable-arts "
	use esd && myconf="--enable-esd "
	use sdl && myconf="--enable-sdl "
	use oggvorbis && myconf="--enable-vorbis "
	use smpeg && myconf="--enable-smpeg "

	cd ${S}/linux

	# disabling -Werror and -Wpedantic-error so it actually builds
	mv configure.in configure.in.orig
	sed "s|-Werror -pedantic-errors||" configure.in.orig > configure.in

	./autogen.sh || die

	./configure --enable-arch-asm --prefix=/usr ${myconf} || die
	emake all || die

}

src_install() {

	cd ${S}/linux

	# symlink creation disabled -- see below
	make install DESTDIR=${D}/usr/ LN_S="echo " || die

	dodoc CREDITS ChangeLog INSTALL NOTES PLATFORM TODO
	makeinfo doc/openal.texi
	doinfo doc/openal.info

	cd ${S}
	dodoc CHANGES COPYING CREDITS
	dohtml docs/*.html
	
	# something is screwy with the makefiles so we create the two library
	# symlinks manually
	cd ${D}/usr/lib
	ln -f -s libopenal.so.${LIBVER} libopenal.so.0 || die
	ln -f -s libopenal.so.${LIBVER} libopenal.so || die
}

