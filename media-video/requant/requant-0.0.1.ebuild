# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/requant/requant-0.0.1.ebuild,v 1.2 2006/04/01 17:00:39 zzam Exp $

REQUANT="M2VRequantizer"
REQUANT_VN="20030925"
JAU_FILE="repackmpeg2-v0.9"

DESCRIPTION="Tool to requantize/shrink mpeg2 videos"
HOMEPAGE="http://www.jausoft.com"
SRC_URI="mirror://vdrfiles/requant/${JAU_FILE}.tar.bz2"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

S=${WORKDIR}/${JAU_FILE}

src_unpack() {
	unpack ${A}
	tar xjf ${S}/${REQUANT}-${REQUANT_VN}.tar.bz2
}

src_compile() {

	cd ${WORKDIR}/${REQUANT}-${REQUANT_VN}/src
	gcc -c ${CFLAGS} main.c -o requant.o
	gcc ${CFLAGS} requant.o -o requant -lm
}

src_install() {

	dobin ${WORKDIR}/${REQUANT}-${REQUANT_VN}/src/requant
}

