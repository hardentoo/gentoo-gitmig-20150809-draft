# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-x11/qt-x11-2.2.3.ebuild,v 1.3 2000/12/25 16:17:42 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/qt-${PV}
DESCRIPTION="QT 2.2"
SRC_PATH="kde/stable/2.0/distribution/tar/generic/src/${A}"
SRC_URI="ftp://ftp.trolltech.com/pub/qt/source/${A}"
HOMEPAGE="http://www.kde.org/"

DEPEND=">=media-libs/libpng-1.0.7
	>=media-libs/libmng-0.9.3
	>=media-libs/mesa-3.4
	>=media-sound/nas-1.4.1
	>=x11-base/xfree-4.0.2"

export QTDIR=${S}

src_unpack() {
  unpack ${A}
  cd ${S}
  cp configure configure.orig
  sed -e "s:read acceptance:acceptance=yes:" configure.orig > configure
}

src_compile() {
    cd ${S}
    export LDFLAGS="-ldl"
    ./configure -sm -thread -system-zlib -system-jpeg -system-nas-sound \
	-system-libmng -system-libpng -gif -platform linux-g++ -ldl -lpthread
    cd ${S}/src
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/tools
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/src/moc
    cp Makefile Makefile.orig
    sed -e "s/-pipe -O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}
    try make symlinks src-moc src-mt sub-src sub-tools
}

src_install() {

        QTBASE=/usr/X11R6/lib
	cd ${S}
	dodir $QTBASE/${P}
	into $QTBASE/${P}
	dobin bin/*
	dolib.so lib/libqt.so.${PV}
	dolib.so lib/libqt-mt.so.${PV}
	dolib.so lib/libqutil.so.1.0.0
	preplib $QTBASE/lib/${P}
	dosym	libqt.so.${PV} 	  $QTBASE/${P}/lib/libqt.so
	dosym   libqt-mt.so.${PV} $QTBASE/${P}/lib/libqt-mt.so
	dosym   libqutil.so.1.0.0 $QTBASE/${P}/lib/libqutil.so
	cd ${D}${QTBASE}
 	ln -sf  qt-x11-${PV} qt
	cd ${S}
	dodir ${QTBASE}/${P}/include
	cp include/* ${D}${QTBASE}/${P}/include/
	doman doc/man/man3/*

	dodoc ANNOUNCE FAQ LICENSE.QPL MANIFEST PLATFORMS
	dodoc PORTING README*
        cp -af ${S}/doc/html ${D}/usr/doc/${P}
        insinto /etc/env.d
        doins ${FILESDIR}/15qt

}




