# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://skyblade.homeip.net/xine/XINE-${PV}/source.TAR.BZ2s/xine-lib-${PV}.tar.bz2"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-libs/libdvdcss-1.0.0
	>=media-libs/libdvdread-0.9.2
	X? ( virtual/x11 )
	esd? ( media-sound/esound )
	aalib? ( media-libs/aalib )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )"


src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X     || myconf="${myconf} --disable-x11 --disable-xv"
	use alsa  || myconf="${myconf} --disable-alsa --disable-alsatest"
	use esd   || myconf="${myconf} --disable-esd --disable-esdtest"
	use aalib || myconf="${myconf} --disable-aalib --disable-aalibtest"
	use arts  || myconf="${myconf} --disable-arts --disable-artstest"
	 
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc					\
		    ${myconf} || die
		    
	make || die
}

src_install() {
	
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     sysconfdir=${D}/etc					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia FAQ* MRL.txt README*
	docinto xine-lib-API/html
	rm -f xine-lib-API/html/Makefile*
	dodoc xine-lib-API/html/*
}

