# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/sjeng/sjeng-11.2-r1.ebuild,v 1.2 2004/06/24 22:21:28 agriffis Exp $

inherit games

S="${WORKDIR}/Sjeng-Free-${PV}"
DESCRIPTION="Console based chess interface"
HOMEPAGE="http://sjeng.sourceforge.net/"
SRC_URI="mirror://sourceforge/sjeng/Sjeng-Free-${PV}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_install () {
	make DESTDIR="${D}" install                     || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS || die "dodoc failed"
	prepgamesdirs
}
