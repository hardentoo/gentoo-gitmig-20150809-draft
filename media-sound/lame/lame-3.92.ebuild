# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.92.ebuild,v 1.9 2002/10/04 05:53:53 vapier Exp $

inherit libtool

S=${WORKDIR}/lame-${PV}
DESCRIPTION="LAME Ain't an Mp3 Encoder"
SRC_URI="mirror://sourceforge/lame/${P}.tar.gz"
HOMEPAGE="http://www.mp3dev.org/mp3/"

DEPEND="virtual/glibc
	x86? ( dev-lang/nasm )
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"
# Oggvorbis support breaks with -rc3 
RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	gtk? ( =x11-libs/gtk+-1.2* )"
#	oggvorbis? ( >=media-libs/libvorbis-1.0_rc3 )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"


src_compile() {
	elibtoolize

	local myconf=""
	if [ "`use oggvorbis`" ] ; then
#		myconf="${myconf} --with-vorbis"
		myconf="${myconf} --without-vorbis"
	else
		myconf="${myconf} --without-vorbis"
	fi
	if [ "`use gtk`" ] ; then
		myconf="${myconf} --enable-mp3x"
	fi
	if [ "${DEBUG}" ] ; then
		myconf="${myconf} --enable-debug=yes"
	else
		myconf="${myconf} --enable-debug=no"
	fi
	
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--enable-nasm \
		--enable-mp3rtp \
		--enable-extopt=full \
		${myconf} || die
		
	emake || die
}

src_install () {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		pkghtmldir=${D}/usr/share/doc/${PF}/html \
		install || die

	dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
	dohtml -r ./
}

