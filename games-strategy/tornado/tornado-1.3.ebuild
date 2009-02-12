# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/tornado/tornado-1.3.ebuild,v 1.7 2009/02/12 14:09:39 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Clone of a C64 game -  destroy the opponent's house"
HOMEPAGE="http://home.kcore.de/~kiza/linux/tornado/"
SRC_URI="http://home.kcore.de/~kiza/linux/tornado/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""

src_prepare() {
	sed -i \
		-e "s:PREFIX/bin:${GAMES_BINDIR}:" \
		-e "s:PREFIX/man:/usr/man:" \
		-e "s:/usr/local:/usr:" \
		doc/man/tornado.6.in \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	dogamesbin tornado || die "dogamesbin failed"
	doman doc/man/tornado.6
	dodoc AUTHOR CREDITS Changelog README TODO
	insinto "${GAMES_STATEDIR}"
	doins tornado.scores
	prepgamesdirs
	fperms 664 "${GAMES_STATEDIR}/tornado.scores"
}
