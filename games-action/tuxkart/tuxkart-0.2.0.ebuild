# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/tuxkart/tuxkart-0.2.0.ebuild,v 1.8 2004/06/19 08:23:14 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A racing game starring Tux, the linux penguin"
HOMEPAGE="http://tuxkart.sourceforge.net"
SRC_URI="mirror://sourceforge/tuxkart/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha amd64"
IUSE=""

DEPEND=">=media-libs/plib-1.6.0
	>=sys-apps/sed-4
	virtual/x11
	virtual/glut
	virtual/opengl"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/01tuxkart.patch"

	# apparently <sys/perm.h> doesn't exist on alpha
	if use alpha; then
		epatch "${FILESDIR}/tuxkart-0.2.0-alpha.patch"
	fi

	sed -i \
		-e "/^plib_suffix/ s/-lplibul/-lplibul -lplibjs/" \
		-e "s/-malign-double//; s/-O6//" "${S}/configure" \
		|| die "sed configure failed"
}

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CHANGES README
	dohtml doc/*.html
	rm -rf "${D}/usr/share/tuxkart/"

	prepgamesdirs
}
