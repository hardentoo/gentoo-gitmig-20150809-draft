# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/betna/betna-0.9.7.ebuild,v 1.1 2004/06/02 02:18:07 mr_bones_ Exp $

inherit games

DESCRIPTION="Defend your volcano from the attacking ants by firing rocks/bullets at them"
HOMEPAGE="http://koti.mbnet.fi/makegho/c/betna/"
SRC_URI="http://koti.mbnet.fi/makegho/c/betna/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.7"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Edit game data path
	sed -i \
		-e "s:images/:${GAMES_DATADIR}/${PN}/:" \
		src/main.cpp || die "sed main.cpp failed"

	# Edit CXXFLAGS
	sed -i \
		-e "s:-O2:${CXXFLAGS}:" \
		Makefile || die "sed Makefile failed"
}

src_install() {
	dogamesbin betna || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins images/* || die "doins failed"
	dodoc README Q\&A
	prepgamesdirs
}
