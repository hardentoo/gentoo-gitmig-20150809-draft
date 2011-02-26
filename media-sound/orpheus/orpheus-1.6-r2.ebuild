# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/orpheus/orpheus-1.6-r2.ebuild,v 1.1 2011/02/26 12:28:33 aballier Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Command line MP3 player."
HOMEPAGE="http://konst.org.ua/en/orpheus"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	media-libs/libvorbis
	media-sound/mpg123
	media-sound/vorbis-tools[ogg123]"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/1.5-amd64.patch

	# Fix a stack-based buffer overflow in kkstrtext.h in ktools library.
	# Bug 113683, CVE-2005-3863.
	epatch "${FILESDIR}"/101_fix-buffer-overflow.diff

	epatch "${FILESDIR}"/${P}-nolibghttp.patch \
		"${FILESDIR}"/${P}-cppflags.patch \
		"${FILESDIR}"/${P}-bufsize.patch \
		"${FILESDIR}"/${P}-constify.patch
	cp "${S}/config.rpath" "${S}/kkstrtext-0.1/" || die

	# For automake 1.9 and later
	sed -i -e 's:@MKINSTALLDIRS@:$(top_srcdir)/mkinstalldirs:' \
		po/Makefile.in.in || die

	einfo "Removing outdated files..."
	find . -name "missing" -print -delete
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
