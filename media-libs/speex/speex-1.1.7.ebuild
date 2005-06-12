# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/speex/speex-1.1.7.ebuild,v 1.5 2005/06/12 22:54:11 kloeri Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Speech encoding library"
HOMEPAGE="http://www.speex.org"
SRC_URI="http://www.speex.org/download/${MY_P}.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 sparc x86"
IUSE="ogg sse"

DEPEND="virtual/libc
	ogg? ( >=media-libs/libogg-1.0 )"

src_compile() {
	local myconf
	use ogg \
		&& myconf="--enable-ogg=yes --with-ogg-dir=/usr" \
		|| myconf="--enable-ogg=no"
	if [ "${ARCH}" != "amd64" ]
	then
		use sse && myconf="${myconf} --enable-sse"
	fi
	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	rm -rf ${D}/usr/share/doc/*

	insinto /usr/share/doc/${P}
	doins ${S}/doc/manual.pdf
	dodoc AUTHORS ChangeLog README TODO NEWS
}
