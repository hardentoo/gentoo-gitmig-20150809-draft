# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ncmpc/ncmpc-0.17.ebuild,v 1.2 2010/08/06 12:18:52 ssuominen Exp $

EAPI=3
inherit autotools eutils multilib

DESCRIPTION="A ncurses client for the Music Player Daemon (MPD)"
HOMEPAGE="http://mpd.wikia.com/wiki/Client:Ncmpc"
SRC_URI="http://downloads.sourceforge.net/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="artist-screen colors debug +help-screen key-screen lirc lyrics-screen mouse nls search-screen song-screen"

RDEPEND=">=dev-libs/glib-2.12:2
	>=media-libs/libmpdclient-2
	sys-libs/ncurses
	lirc? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.16.1-asneeded.patch \
		"${FILESDIR}"/${PN}-0.16.1-lyrics-backtrace.patch \
		"${FILESDIR}"/${P}-fix-segfault-on-help-screen.patch
	eautoreconf
}

src_configure() {
	# upstream lirc doesn't have pkg-config file wrt #250015
	if use lirc; then
		export LIBLIRCCLIENT_CFLAGS="-I${EPREFIX}/usr/include/lirc"
		export LIBLIRCCLIENT_LIBS="-llirc_client"
	fi

	# use_with lyrics-screen is for multilib
	econf \
		--docdir=${EPREFIX}/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		$(use_enable nls multibyte) \
		$(use_enable nls locale) \
		$(use_enable nls) \
		$(use_enable colors) \
		$(use_enable lirc) \
		$(use_enable help-screen) \
		$(use_enable mouse) \
		$(use_enable artist-screen) \
		$(use_enable search-screen) \
		$(use_enable song-screen) \
		$(use_enable key-screen) \
		$(use_enable lyrics-screen) \
		$(use_enable debug) \
		$(use_with lyrics-screen lyrics-plugin-dir /usr/$(get_libdir)/ncmpc/lyrics)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README doc/*.sample
}
