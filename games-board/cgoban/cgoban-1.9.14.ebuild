# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/cgoban/cgoban-1.9.14.ebuild,v 1.10 2012/09/03 18:28:30 tupone Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="A Go-frontend"
HOMEPAGE="http://cgoban1.sourceforge.net/"
SRC_URI="mirror://sourceforge/cgoban1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	|| (
		media-gfx/imagemagick
		media-gfx/graphicsmagick[imagemagick]
	)
	x11-libs/libX11
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	cp cgoban_icon.png ${PN}.png || die "cp failed"
	mv configure.{in,ac} || dir "mv configure failed"
	epatch "${FILESDIR}"/${P}-cflags.patch
#	sed -i -e "/^WMS_GET_CFLAGS/d" \
#		configure.ac || die "sed failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	doicon ${PN}.png
	make_desktop_entry cgoban Cgoban
	prepgamesdirs
}
