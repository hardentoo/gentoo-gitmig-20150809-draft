# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg2vidcodec/mpeg2vidcodec-12-r1.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

MY_P=${PN}_v${PV}
S=${WORKDIR}/mpeg2
DESCRIPTION="MPEG Library"
SRC_URI="ftp://ftp.mpeg.org/pub/mpeg/mssg/${MY_P}.tar.gz"
HOMEPAGE="http://www.mpeg.org"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack () {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}
src_compile() {

	cd ${S}
	make || die

}

src_install () {

	cd ${S}
	into /usr
	dobin src/mpeg2dec/mpeg2decode
	dobin src/mpeg2enc/mpeg2encode
	dodoc README doc/*

}
